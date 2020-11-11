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
    func downloadLabels(token: String, completion: @escaping (Result<[Label], Error>) -> Void)
    func downloadMilestones(token: String, completion: @escaping (Result<[Milestone], Error>) -> Void)
    
}

class IssueTrackerNetworkManager: NetworkManager {
    static let shared = IssueTrackerNetworkManager()
    let baseURL = "http://api.hoyoung.me/api"
    
    private init() { }
    
    enum NetworkError: Error {
        case cookeyError, dataError, requestError
    }
    
    func downloadIssues(token: String, completion: @escaping (Result<[Issue], Error>) -> Void) {
        let url = baseURL + "/issue"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .get, parameters: nil, headers: nil).responseData { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            
            guard let data = responseObject.data else { completion(.failure(NetworkError.dataError)); return }
            
            do {
                completion(.success(try JSONDecoder().decode([Issue].self, from: data)))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    func createIssue(token: String, issue: Issue, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/issue"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .post, parameters: issue, encoder: JSONParameterEncoder.default).responseData { (responseObject) -> Void in
            
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                dump(responseObject)
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    func changeIssueTitle(token: String, newTitle: String, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/issue" + "/\(issueID)"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .patch, parameters: newTitle, encoder: JSONParameterEncoder.default).responseData { (responseObject) -> Void in
            
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                dump(responseObject)
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    func changeIssueUser(token: String, newUser: User, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/issue" + "/\(issueID)"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .patch, parameters: newUser, encoder: JSONParameterEncoder.default).responseData { (responseObject) -> Void in
            
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                dump(responseObject)
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    func changeIssueMilestone(token: String, milestone: Milestone, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/issue" + "/\(issueID)" + "/milestone"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .patch, parameters: milestone, encoder: JSONParameterEncoder.default).responseData { (responseObject) -> Void in
            
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                dump(responseObject)
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    func addIssueLabel(token: String, label: Label, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/issue" + "/issueLabel" + "/\(issueID)"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .patch, parameters: label, encoder: JSONParameterEncoder.default).responseData { (responseObject) -> Void in
            
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                dump(responseObject)
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    func deleteIssueLabel(token: String, label: Label, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/issue" + "/issueLabel" + "/\(issueID)"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .patch, parameters: label, encoder: JSONParameterEncoder.default).responseData { (responseObject) -> Void in
            
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                dump(responseObject)
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    //FIXME: 모든 레이블을 삭제하는 동작의 필요성
    func deleteAllIssueLabel() {
        
    }
    
    func changeIssueStatus(token: String, status: Int, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/issue" + "/status" + "/\(status)" + "/\(issueID)"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .patch, parameters: nil).responseData { (responseObject) -> Void in
            
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                dump(responseObject)
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    //FIXME: IssueLabel인지 Label인지?
    func downloadLabels(token: String, completion: @escaping (Result<[Label], Error>) -> Void) {
        let url = baseURL + "/label"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .get, parameters: nil).responseData { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            guard let data = responseObject.data else { completion(.failure(NetworkError.dataError)); return }
            
            do {
                completion(.success(try JSONDecoder().decode([Label].self, from: data)))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    func createLabel(token: String, label: Label, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/label"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .post, parameters: label, encoder: JSONParameterEncoder.default).responseData { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            completion(.success(true))
            
        }
    }
    
    //FIXME: 파라미터 수정필요
    func editLabel(token: String, label: Label, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/label"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .post, parameters: label, encoder: JSONParameterEncoder.default).responseData { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    func deleteLabel(token: String, label: Label, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/label"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .delete, parameters: label, encoder: JSONParameterEncoder.default).responseData { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    func downloadMilestones(token: String, completion: @escaping (Result<[Milestone], Error>) -> Void) {
        let url = baseURL + "/milestone"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .get, parameters: nil).responseData { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            guard let data = responseObject.data else { completion(.failure(NetworkError.dataError)); return }
            
            do {
                completion(.success(try JSONDecoder().decode([Milestone].self, from: data)))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    //FIXME: miletone 상세 조회
    func detailMilestone() {
        
    }
    
    func addMilestone(token: String, milestone: Milestone, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/milestone"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .post, parameters: milestone, encoder: JSONParameterEncoder.default).responseData { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    func editMilestone(token: String, milestone: Milestone, milestoneID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/milestone" + "/\(milestoneID)"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .post, parameters: milestone, encoder: JSONParameterEncoder.default).responseData { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    func deleteMilestone(token: String, milestone: Milestone, milestoneID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/milestone" + "/\(milestoneID)"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .delete, parameters: nil).responseData { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    func downloadComments(token: String, issueID: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        let url = baseURL + "/comment" + "/\(issueID)"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .get, parameters: nil).responseData { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            guard let data = responseObject.data else { completion(.failure(NetworkError.dataError)); return }
            
            do {
                completion(.success(try JSONDecoder().decode([Comment].self, from: data)))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    func addComment(token: String, comment: Comment, issueID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/comment" + "/\(issueID)"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .post, parameters: comment, encoder: JSONParameterEncoder.default).responseData { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    func editComment(token: String, comment: Comment, commentID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/comment" + "/\(commentID)"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .patch, parameters: comment, encoder: JSONParameterEncoder.default).responseData { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    func deleteComment(token: String, commentID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/comment" + "/\(commentID)"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: token
        ]
        
        guard let cookie = HTTPCookie(properties: cookieProps) else { completion(.failure(NetworkError.cookeyError)); return }
        AF.session.configuration.httpCookieStorage?.setCookie(cookie)
        AF.request(url, method: .delete).responseData { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                let error = NetworkError.requestError.asAFError(orFailWith: "Response failed, code: " + "\(String(describing: responseObject.response?.statusCode))")
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
}
