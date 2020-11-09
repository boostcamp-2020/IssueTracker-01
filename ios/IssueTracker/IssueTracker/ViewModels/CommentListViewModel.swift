//
//  CommentListViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/08.
//

import UIKit

class CommentListViewModel {
    var items = [CommentViewModel]()
    weak var delegate: SnapshotApplicable?
    
    func download(issueID: Int) {
        NetworkManager().downloadCommentList(issueID: issueID ) { [weak self] result in
            switch result {
            case .success(let issue):
                self?.items = issue.comments.map { CommentViewModel(comment: $0) }
                DispatchQueue.main.async {
                    self?.delegate?.applySnapshot(animatingDifferences: true)
                }
            case .error(let error):
                print(error)
            }
        }
    }
}
