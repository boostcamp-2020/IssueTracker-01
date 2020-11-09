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
    
    private init() { }
    
    enum NetworkError: Error {
        case cookeyError, dataError, requestError
    }
    
    func downloadIssues(token: String, completion: @escaping (Result<[Issue], Error>) -> Void) {
        let url = "http://api.hoyoung.me/api/issue"
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
}
