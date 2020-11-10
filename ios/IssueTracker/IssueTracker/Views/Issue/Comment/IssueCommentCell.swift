//
//  IssueCommentCell.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/08.
//

import UIKit

class IssueCommentCell: UICollectionViewListCell {
    @IBOutlet weak var userImageView: UIImageView?
    @IBOutlet weak var userNameLabel: UILabel?
    @IBOutlet weak var commentDateLabel: UILabel?
    @IBOutlet weak var commentLabel: UILabel?
    
    func configureCell(viewModel: CommentCellViewModel) {
        userNameLabel?.text = viewModel.user?.userID
        commentDateLabel?.text = viewModel.configureDate()
        commentLabel?.text = viewModel.content
    }
}
