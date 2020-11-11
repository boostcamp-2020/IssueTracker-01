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
    
    init(comments: [Comment]) {
        commentCellViewModels = comments.map { CommentCellViewModel(comment: $0) }
    }
}
