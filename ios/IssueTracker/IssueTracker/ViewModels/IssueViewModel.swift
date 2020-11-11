//
//  IssueViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/04.
//

import UIKit

class IssueViewModel {
    var issueCellViewModels = [IssueCellViewModel]() {
        didSet { issueChangeHandler?() }
    }
    
    var issueChangeHandler: (() -> Void)?
    var token: String?
    var networkManager: NetworkManager?
    
    init(networkManager: NetworkManager?) {
        self.networkManager = networkManager
    }
    
    func downloadData() {
        networkManager?.downloadIssues { [weak self] result in
            switch result {
            case let .success(result):
                self?.issueCellViewModels = result.map { IssueCellViewModel(issue: $0) }
            case let .failure(result):
                print(result.localizedDescription)
            }
        }
    }
}
