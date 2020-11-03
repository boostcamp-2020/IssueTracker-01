//
//  GithubLoginManager.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/10/28.
//

import Foundation
import UIKit

protocol GithubLogin {
    var token: String? { get }
    func requestCode(requestHandler: (() -> Void)?)
}

protocol GithubLoginManagerDelegate: class {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL)
}

final class GithubLoginManager: GithubLogin {
    
    enum GithubLoginManagerError: Error {
        case haveNoAccessToken
    }
    
    var completionHandler: (() -> Void)?
    
    static let shared = GithubLoginManager()
    
    weak var delegate: GithubLoginManagerDelegate?
    
    var token: String?
    
    private init() { }
    
    func requestCode(requestHandler: (() -> Void)?) {
        let urlString = "http://hoyoung.me/oauth/login/github"
        guard let url = URL(string: urlString)  else { return }
        guard let canOpenURL = delegate?.canOpenURL(url) else { return }
        guard canOpenURL else { return }
        self.completionHandler = requestHandler
        delegate?.open(url)
    }
}
