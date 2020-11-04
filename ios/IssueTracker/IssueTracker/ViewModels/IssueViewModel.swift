//
//  IssueViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/03.
//

import UIKit

class IssueViewModel {
    
    var items: [Issue]?
    weak var delegate: UICollectionView?
    
    init(items: [Issue]) {
        NetworkManager().downloadIssueList { [weak self] result in
            switch result {
            case .success(let issues):
                self?.items = issues
                self?.delegate?.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
    
}
