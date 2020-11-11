//
//  CommentViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/08.
//

import UIKit

class IssueDetailViewModel {
    let issueBottomSheetViewModel: IssueBottomSheetViewModel
    
    var commentCellViewModels = [CommentCellViewModel]() {
        didSet { itemSetHandler?() }
    }
    
    var itemSetHandler: (() -> Void)?
    
    init(comments: [Comment], issueBottomSheetViewModel: IssueBottomSheetViewModel) {
        self.commentCellViewModels = comments.map { CommentCellViewModel(comment: $0) }
        self.issueBottomSheetViewModel = issueBottomSheetViewModel
    }
}
