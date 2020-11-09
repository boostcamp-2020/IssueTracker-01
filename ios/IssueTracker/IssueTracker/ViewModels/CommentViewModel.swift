//
//  CommentViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/08.
//

import UIKit

class CommentViewModel {
    var commentCellViewModels = [CommentCellViewModel]() {
        didSet { itemSetHandler?() }
    }
    
    var itemSetHandler: (() -> Void)?
    var token: String?
    var issueID: Int?
    var networkManager: NetworkManager?
    
    init(token: String?, networkManager: NetworkManager?) {
        self.token = token
        self.networkManager = networkManager
    }
    
    func downloadData() {
        guard let token = token, let issueID = issueID else { return }
        networkManager?.downloadComment(token: token, issueID: issueID) { [weak self] result in
            switch result {
            case let .success(result):
                self?.commentCellViewModels = result.comments.map { CommentCellViewModel(comment: $0) }
            case let .failure(result):
                print(result.localizedDescription)
            }
        }
    }
}
