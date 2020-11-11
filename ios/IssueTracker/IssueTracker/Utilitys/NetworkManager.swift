//
//  NetworkManager.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/03.
//

import Foundation
import Alamofire

protocol NetworkManager {
    func downloadIssues(token: String, completion: @escaping (Result<[Issue], Error>) -> Void)
}

class IssueTrackerNetworkManager: NetworkManager {
    static let shared = IssueTrackerNetworkManager()
    let baseURL = "http://api.hoyoung.me/api"
    
    private init() { }
    
    enum NetworkError: Error {
        case cookeyError, dataError, requestError
    }
    
    private func configureCookie(token: String) -> Bool {
        guard let cookie = HTTPCookie(properties: [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]) else { return false }
        
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        return true
    }
    
    private func response<T: Decodable>(responseObject: AFDataResponse<Data>, completion: @escaping (Result<T, Error>) -> Void) {
        guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
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
    
    func downloadIssues(token: String, completion: @escaping (Result<[Issue], Error>) -> Void) {
        let url = baseURL + "/issue"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .get, completion: completion)
    }
    
    func addIssue(token: String, issue: Issue, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/issue"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .post, parameters: IssueParameter(issue: issue), completion: completion)
    }
    
    func changeIssueTitle(token: String, title: String, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/issue/\(issueID)"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .patch, parameters: title, completion: completion)
    }
    
    func changeIssueUser(token: String, user: User, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/issue/\(issueID)"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .patch, parameters: user, completion: completion)
    }
    
    func changeIssueMilestone(token: String, milestone: Milestone, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/issue/\(issueID)/milestone"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .patch, parameters: milestone, completion: completion)
    }
    
    func addIssueLabel(token: String, label: Label, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/issue/issueLabel/\(issueID)"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .patch, parameters: label, completion: completion)
    }
    
    // FIXME: addIssueLable()과 기능이 같음
    func deleteIssueLabel(token: String, label: Label, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/issue/issueLabel/\(issueID)"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .patch, parameters: label, completion: completion)
    }
    
    // TODO: 모든 레이블을 삭제하는 동작 필요
    func deleteAllIssueLabel() {
        
    }
    
    func changeIssueStatus(token: String, status: Int, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/issue/status/\(status)/\(issueID)"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .patch, completion: completion)
    }
    
    // TODO: IssueLabel인지 Label인지?
    func downloadLabels(token: String, completion: @escaping (Result<[Label], Error>) -> Void) {
        let url = baseURL + "/label"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .get, completion: completion)
    }
    
    func createLabel(token: String, label: Label, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/label"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .post, parameters: label, completion: completion)
    }
    
    // FIXME: 파라미터 수정필요
    func editLabel(token: String, label: Label, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/label"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .post, parameters: label, completion: completion)
    }
    
    func deleteLabel(token: String, label: Label, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/label"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .delete, parameters: label, completion: completion)
    }
    
    func downloadMilestones(token: String, completion: @escaping (Result<[Milestone], Error>) -> Void) {
        let url = baseURL + "/milestone"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .get, completion: completion)
    }
    
    // TODO : miletone 상세 조회
    func detailMilestone() {
        
    }
    
    func addMilestone(token: String, milestone: Milestone, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/milestone"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .post, parameters: milestone, completion: completion)
    }
    
    func editMilestone(token: String, milestone: Milestone, milestoneID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/milestone" + "/\(milestoneID)"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .post, parameters: milestone, completion: completion)
    }
    
    func deleteMilestone(token: String, milestone: Milestone, milestoneID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/milestone" + "/\(milestoneID)"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .delete, completion: completion)
    }
    
    func downloadComments(token: String, issueID: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        let url = baseURL + "/comment" + "/\(issueID)"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .get, completion: completion)
    }
    
    func addComment(token: String, comment: Comment, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/comment" + "/\(issueID)"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .post, parameters: comment, completion: completion)
    }
    
    func editComment(token: String, comment: Comment, commentID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/comment" + "/\(commentID)"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .patch, parameters: comment, completion: completion)
    }
    
    func deleteComment(token: String, commentID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/comment" + "/\(commentID)"
        guard configureCookie(token: token) else { completion(.failure(NetworkError.cookeyError)); return }
        request(url: url, method: .delete, completion: completion)
    }
}
