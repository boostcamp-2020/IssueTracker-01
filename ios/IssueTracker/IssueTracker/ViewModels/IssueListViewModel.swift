//
//  IssueViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/03.
//

import UIKit

protocol SnapshotApplicable: class {
    func applySnapshot(animatingDifferences: Bool)
}

class IssueListViewModel {
    var items = [IssueViewModel]()
    weak var delegate: SnapshotApplicable?
    
    func download() {
        NetworkManager().downloadIssueList { [weak self] result in
            switch result {
            case .success(let issueElement):
                let issueViewModels = issueElement.issues.map { IssueViewModel(issue: $0) }
                self?.items = issueViewModels
                DispatchQueue.main.async {
                    self?.delegate?.applySnapshot(animatingDifferences: true)
                }
            case .error(let error):
                print(error)
            }
        }
    }
}
