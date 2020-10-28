//
//  GithubLoginManager.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/10/28.
//

import Foundation
import UIKit

protocol GithubLogin {
    func requestCode()
}

protocol GithubLoginManagerDelegate: class {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL)
}

final class GithubLoginManager: GithubLogin {
    private let clientId = "e9eac94fb40d8f0685f0"
    
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
}
