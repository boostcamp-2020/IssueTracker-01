//
//  NetworkManager.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/03.
//

import Foundation
import Alamofire

class NetworkManager {
    func downloadIssueList(completion: @escaping (Result<IssueElement>) -> Void) {
        let url = "http://api.hoyoung.me/api/issue"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: "\(GithubLoginManager.shared.token!)"
        ]
        if let cookie = HTTPCookie(properties: cookieProps) {
            AF.session.configuration.httpCookieStorage!.setCookie(cookie)
        }
        AF.request(url, method: .get, parameters: nil, headers: nil).responseData { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                print("response failed, code : " + "\(responseObject.response?.statusCode)")
                return
                }
            dump(GithubLoginManager.shared.token)
            guard let data =  responseObject.data else { return }
            do {
                let issueElement = try JSONDecoder().decode(IssueElement.self, from: data)
                completion(.success(issueElement))
            } catch let error {
                completion(.error(error))
            }
        }
    }
    
    func downloadCommentList(issueID: Int, completion: @escaping (Result<Issue>) -> Void) {
        let url = "http://api.hoyoung.me/api/issue/detailIssue/" + "\(issueID)"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: "\(GithubLoginManager.shared.token!)"
        ]
        if let cookie = HTTPCookie(properties: cookieProps) {
            AF.session.configuration.httpCookieStorage!.setCookie(cookie)
        }
        AF.request(url, method: .get, parameters: nil, headers: nil).responseData { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                print("response failed, code : " + "\(responseObject.response?.statusCode)")
                return
                }
            guard let data =  responseObject.data else { return }
            do {
                let issue = try JSONDecoder().decode(Issue.self, from: data)
                completion(.success(issue))
            } catch let error {
                completion(.error(error))
            }
        }
    }
    
    func createIssue(issue: Issue) {
        let url = "http://api.hoyoung.me/api/issue"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: "\(GithubLoginManager.shared.token!)"
        ]
        if let cookie = HTTPCookie(properties: cookieProps) {
            AF.session.configuration.httpCookieStorage!.setCookie(cookie)
        }
        
        AF.request(url, method: .post, parameters: issue, encoder: JSONParameterEncoder.default).responseData { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                print("response failed, code : " + "\(responseObject.response?.statusCode)")
                return
            }
            //성공시 행동
        }
    }
    
    func createComment(comment: Comment) {
        let url = "http://api.hoyoung.me/api/issue"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: "\(GithubLoginManager.shared.token!)"
        ]
        if let cookie = HTTPCookie(properties: cookieProps) {
            AF.session.configuration.httpCookieStorage!.setCookie(cookie)
        }
        
        AF.request(url, method: .post, parameters: comment, encoder: JSONParameterEncoder.default).responseData { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                print("response failed, code : " + "\(responseObject.response?.statusCode)")
                return
            }
            //성공시 행동
        }
    }
    
    func createLabel(label: Label) {
        let url = "http://api.hoyoung.me/api/label"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "api.hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "jwt",
            HTTPCookiePropertyKey.value: "\(GithubLoginManager.shared.token!)"
        ]
        if let cookie = HTTPCookie(properties: cookieProps) {
            AF.session.configuration.httpCookieStorage!.setCookie(cookie)
        }
        
        AF.request(url, method: .post, parameters: label, encoder: JSONParameterEncoder.default).responseData { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                print("response failed, code : " + "\(responseObject.response?.statusCode)")
                return
            }
            //성공시 행동
        }
    }
}

enum Result<T> {
    case success(T)
    case error(Error)
}


