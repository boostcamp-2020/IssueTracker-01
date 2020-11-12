//
//  IssueAddViewModel.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/11.
//

import Foundation

class IssueAddViewModel {
    private var networkManager: NetworkManager?
    var addIssueCompletion: (() -> Void)?
    
    init(networkManager: NetworkManager?) {
        self.networkManager = networkManager
    }
    
    func addIssue(title: String, completion viewControllerCompletion: (() -> Void)?) {
        let newIssue = Issue(title: title)
        networkManager?.addIssue(issue: newIssue) { [weak self] result in
            switch result {
            case let .success(result):
                guard result.message == "Success" else { print("error: ", result.message ?? ""); return }
                self?.addIssueCompletion?()
                viewControllerCompletion?()
            case let .failure(result):
                print(result.localizedDescription)
            }
        }
    }
}
