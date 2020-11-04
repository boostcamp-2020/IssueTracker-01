//
//  IssueViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/03.
//

import UIKit

class IssueListViewModel {
    
    var items = [IssueViewModel]()
    weak var delegate: UICollectionView?
    
    init() {
        NetworkManager().downloadIssueList { [weak self] result in
            switch result {
            case .success(let issues):
                let issueViewModels = issues.map { IssueViewModel(issue: $0) }
                self?.items = issueViewModels
                self?.delegate?.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
}
