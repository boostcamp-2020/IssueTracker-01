//
//  CommentListViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/08.
//

import UIKit

class CommentListViewModel {
    var items = [Comment]()
    weak var delegate: SnapshotApplicable?
    
    func download() {
        NetworkManager().downloadCommentList { [weak self] result in
            switch result {
            case .success(let issue):
                self?.items = issue.comments
                DispatchQueue.main.async {
                    self?.delegate?.applySnapshot(animatingDifferences: true)
                }
            case .error(let error):
                print(error)
            }
        }
    }
}
