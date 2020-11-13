//
//  NetworkManager.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/03.
//

import Foundation
import Alamofire

protocol NetworkManager {
    var hasToken: Bool { get }
    func requestGithubLogin(requestHandler: (() -> Void)?)
    func urlDataDownload(_ url: URL, completionHandler: ((Result<String, Error>)->())?)
    func downloadIssues(isOpen: Bool, completion: @escaping (Result<[Issue], Error>) -> Void)
    func addIssue(issue: Issue, completion: @escaping (Result<ServerResponse, Error>) -> Void)
    func closeIssue(issueID: Int, completion: @escaping (Result<ServerResponse, Error>) -> Void)
    func downloadLabels(completion: @escaping (Result<LabelList, Error>) -> Void)
    func downloadMilestones(completion: @escaping (Result<[Milestone], Error>) -> Void)
}

protocol GithubLoginDelegate: class {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL)
}

class IssueTrackerNetworkManager: NetworkManager {    
    static let shared = IssueTrackerNetworkManager()
    weak var delegate: GithubLoginDelegate?
    var githubLoginCompletionHandler: (() -> Void)?
    
    private init() { }
}

// MARK: Information to communicate with server
extension IssueTrackerNetworkManager {
    struct Info {
        static let baseURL = "http://api.hoyoung.me/api"
        static var token: String?
    }
}

// MARK: Github Login
extension IssueTrackerNetworkManager {
    var hasToken: Bool { Info.token != nil ? true:false }
    
    enum GithubLoginManagerError: Error {
        case haveNoAccessToken
    }
    
    func requestGithubLogin(requestHandler: (() -> Void)?) {
        let urlString = "http://api.hoyoung.me/oauth/github"
        guard let url = URL(string: urlString)  else { return }
        guard let canOpenURL = delegate?.canOpenURL(url) else { return }
        guard canOpenURL else { return }
        self.githubLoginCompletionHandler = requestHandler
        delegate?.open(url)
    }
    
    func checkGithubResponse(openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        guard url.absoluteString.starts(with: "issuetracker://") else { return }
        guard let token = url.absoluteString.split(separator: "/").last.map({ String($0) }) else { return }
        Info.token = token
        githubLoginCompletionHandler?()
    }
}

// MARK: User data
extension IssueTrackerNetworkManager {
    private var cookie: HTTPCookie? {
        HTTPCookie(properties: [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: Info.token ?? ""
        ])
    }
    
    enum NetworkError: Error {
        case urlError, cookeyError, dataError, requestError
    }
    
    func urlDataDownload(_ url: URL, completionHandler: ((Result<String, Error>)->())?) {
        guard let documentsURL = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            URLSession.shared.downloadTask(with: url) { urlOrNil, responseOrNil, errorOrNil in
                guard let fileURL = urlOrNil else { completionHandler?(.failure(NetworkError.urlError)); return }
                do {
                    let documentsURL = try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    let savedURL = documentsURL.appendingPathComponent(url.lastPathComponent)
                    try FileManager.default.moveItem(at: fileURL, to: savedURL)
                    completionHandler?(.success(documentsURL.appendingPathComponent(url.lastPathComponent).path))
                } catch {
                    print ("file error: \(error)")
                    completionHandler?(.failure(NetworkError.urlError))
                }
            }.resume()
            return
        }
        completionHandler?(.success(documentsURL.appendingPathComponent(url.lastPathComponent).path))
    }
    
    private func configureCookie() -> Bool {
        guard let cookie = cookie else { return false }
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        return true
    }
    
    private func response<T: Decodable>(responseObject: AFDataResponse<Data>, completion: @escaping (Result<T, Error>) -> Void) {
        guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
            dump(responseObject)
            let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
            completion(.failure(error))
            return
        }
        
        guard let data = responseObject.data else { completion(.failure(NetworkError.dataError)); return }
        
        do {
            completion(.success(try JSONDecoder().decode(T.self, from: data)))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    private func request<T: Decodable>(url: String, method: HTTPMethod, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: method).responseData { [weak self] (responseObject) in
            self?.response(responseObject: responseObject, completion: completion)
        }
    }
    
    private func request<T: Decodable, U: Encodable>(url: String, method: HTTPMethod, parameters: U, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: method, parameters: parameters, encoder: JSONParameterEncoder.default).responseData { [weak self] (responseObject) in
            self?.response(responseObject: responseObject, completion: completion)
        }
    }
    
    func downloadIssues(isOpen: Bool, completion: @escaping (Result<[Issue], Error>) -> Void) {
        var url = Info.baseURL + "/issue"
        if isOpen {
            url += "?q=is:open"
        } else {
            url += "?q=is:close"
        }
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .get, completion: completion)
    }
    
    func addIssue(issue: Issue, completion: @escaping (Result<ServerResponse, Error>) -> Void) {
        let url = Info.baseURL + "/issue"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .post, parameters: IssueParameter(issue: issue), completion: completion)
    }
    
    func closeIssue(issueID: Int, completion: @escaping (Result<ServerResponse, Error>) -> Void) {
        let url = Info.baseURL + "/issue/status/0/\(issueID)"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .patch, completion: completion)
    }
    
    func changeIssueTitle(title: String, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = Info.baseURL + "/issue/\(issueID)"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .patch, parameters: title, completion: completion)
    }
    
    func changeIssueUser(user: User, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = Info.baseURL + "/issue/\(issueID)"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .patch, parameters: user, completion: completion)
    }
    
    func changeIssueMilestone(milestone: Milestone, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = Info.baseURL + "/issue/\(issueID)/milestone"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .patch, parameters: milestone, completion: completion)
    }
    
    func addIssueLabel(label: Label, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = Info.baseURL + "/issue/issueLabel/\(issueID)"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .patch, parameters: label, completion: completion)
    }
    
    func deleteIssueLabel(label: Label, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = Info.baseURL + "/issue/issueLabel/\(issueID)"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .delete, parameters: label, completion: completion)
    }
    
    func changeIssueStatus(status: Int, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = Info.baseURL + "/issue/status/\(status)/\(issueID)"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .patch, completion: completion)
    }
    
    func downloadLabels(completion: @escaping (Result<LabelList, Error>) -> Void) {
        let url = Info.baseURL + "/label"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .get, completion: completion)
    }
    
    func createLabel(label: Label, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = Info.baseURL + "/label"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .post, parameters: label, completion: completion)
    }
    
    func deleteLabel(label: Label, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = Info.baseURL + "/label"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .delete, parameters: label, completion: completion)
    }
    
    func downloadMilestones(completion: @escaping (Result<[Milestone], Error>) -> Void) {
        let url = Info.baseURL + "/milestone"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .get, completion: completion)
    }
    
    func addMilestone(milestone: Milestone, completion: @escaping (Result<[String: String], Error>) -> Void) {
        let url = Info.baseURL + "/milestone"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .post, parameters: milestone, completion: completion)
    }
    
    func editMilestone(milestone: Milestone, milestoneID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = Info.baseURL + "/milestone" + "/\(milestoneID)"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .post, parameters: milestone, completion: completion)
    }
    
    func deleteMilestone(milestone: Milestone, milestoneID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = Info.baseURL + "/milestone" + "/\(milestoneID)"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .delete, completion: completion)
    }
    
    func downloadComments(issueID: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        let url = Info.baseURL + "/comment" + "/\(issueID)"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .get, completion: completion)
    }
    
    func addComment(comment: Comment, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = Info.baseURL + "/comment" + "/\(issueID)"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .post, parameters: comment, completion: completion)
    }
    
    func editComment(comment: Comment, commentID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = Info.baseURL + "/comment" + "/\(commentID)"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .patch, parameters: comment, completion: completion)
    }
    
    func deleteComment(commentID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = Info.baseURL + "/comment" + "/\(commentID)"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .delete, completion: completion)
    }
    
    func addLabel(label: LabelParameter, completion: @escaping (Result<LabelResult, Error>) -> Void) {
        let url = Info.baseURL + "/label"
        guard configureCookie() else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .post, parameters: label, completion: completion)
    }
}
