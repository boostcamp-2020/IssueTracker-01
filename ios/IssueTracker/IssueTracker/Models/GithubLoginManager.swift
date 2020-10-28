//
//  GithubLoginManager.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/10/28.
//

import Foundation
import UIKit
import Alamofire

protocol GithubLogin {
    func requestCode()
}

protocol GithubLoginManagerDelegate: class {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL)
}

final class GithubLoginManager: GithubLogin {
    private let clientId = "e9eac94fb40d8f0685f0"
    private let clientSecret = "****"
    
    static let shared = GithubLoginManager()
    
    weak var delegate: GithubLoginManagerDelegate?
    
    private init() { }
    
    func requestCode() {
        let scope = "user"
        let urlString = "https://github.com/login/oauth/authorize?client_id=\(clientId)&scope=\(scope)"
        guard let url = URL(string: urlString)  else { return }
        guard let canOpenURL = delegate?.canOpenURL(url) else { return }
        guard canOpenURL else { return }
        delegate?.open(url)
    }
    
    func requestAccessToken(with code: String) {
        let url = "https://github.com/login/oauth/access_token"
        let parameters = ["client_id": clientId,
                          "client_secret": clientSecret,
                          "code": code]
        
        let headers: HTTPHeaders = ["Accept": "application/json"]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
            case let .success(json):
                if let dic = json as? [String: String] {
                    print(dic["access_token"])
                    print(dic["scope"])
                    print(dic["token_type"])
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
