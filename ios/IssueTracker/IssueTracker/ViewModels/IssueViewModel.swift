//
//  IssueViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/04.
//

import UIKit

class IssueViewModel {
    var issueCellViewModels = [IssueCellViewModel]() {
        didSet { itemSetHandler?() }
    }
    
    var itemSetHandler: (() -> Void)?
    var token: String?
    var networkManager: NetworkManager?
    
    init(token: String?, networkManager: NetworkManager?) {
        self.token = token
        self.networkManager = networkManager
    }
    
    func downloadData() {
        guard let token = token else { return }
        networkManager?.downloadIssues(token: token) { [weak self] result in
            switch result {
            case let .success(result):
                self?.issueCellViewModels = result.map { IssueCellViewModel(issue: $0) }
            case let .failure(result):
                print(result.localizedDescription)
            }
        }
    }
}
