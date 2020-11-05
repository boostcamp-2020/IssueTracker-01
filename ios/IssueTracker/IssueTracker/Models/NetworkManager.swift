//
//  NetworkManager.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/03.
//

import Foundation
import Alamofire

class NetworkManager {
    func downloadIssueList(completion: @escaping (Result<[Issue]>) -> Void) {
        let url = "http://hoyoung.me/api/issue"
        let cookieProps = [
            HTTPCookiePropertyKey.domain: "hoyoung.me",
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "issue",
//            HTTPCookiePropertyKey.value: "\(GithubLoginManager.shared.token!)"
        ]
        if let cookie = HTTPCookie(properties: cookieProps) {
                AF.session.configuration.httpCookieStorage!.setCookie(cookie)
        }
        AF.request(url, method: .get, parameters: nil, headers: nil).responseJSON { (responseObject) -> Void in
            guard let responseCode = responseObject.response?.statusCode, responseCode == 200 else {
                print(responseObject.response?.statusCode)
                return
                }
            guard let data =  responseObject.data else { return }
            do {
                let issueElements = try JSONDecoder().decode(IssueElement.self, from: data)
                completion(.success(issueElements.issues))
            } catch let error {
                completion(.error(error))
            }
        }
    }
}

enum Result<T> {
    case success(T)
    case error(Error)
}
