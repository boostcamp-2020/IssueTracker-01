//
//  GithubLoginManager.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/10/28.
//

import Foundation
import UIKit

protocol GithubLoginManager {
    var token: String? { get }
    func requestGithubLogin(requestHandler: (() -> Void)?)
}

protocol GithubLoginManagerDelegate: class {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL)
}

final class IssueTrackerGithubLoginManager: GithubLoginManager {
    
    enum GithubLoginManagerError: Error {
        case haveNoAccessToken
    }
    
    var githubLoginCompletionHandler: (() -> Void)?
    
    static let shared = IssueTrackerGithubLoginManager()
    
    weak var delegate: GithubLoginManagerDelegate?
    
    var token: String?
    
    private init() { }
    
    func requestGithubLogin(requestHandler: (() -> Void)?) {
        let urlString = "http://api.hoyoung.me/oauth/github"
        guard let url = URL(string: urlString)  else { return }
        guard let canOpenURL = delegate?.canOpenURL(url) else { return }
        guard canOpenURL else { return }
        self.githubLoginCompletionHandler = requestHandler
        delegate?.open(url)
    }
}
