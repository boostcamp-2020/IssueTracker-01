//
//  AssigneeCell.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/11.
//

import UIKit

class AssigneeCell: UICollectionViewCell {
    
    @IBOutlet weak var assigneeImageView: UIImageView!
    @IBOutlet weak var assigneeID: UILabel!
    
    func configureCell(viewModel: IssueCellViewModel) {
//        self.assigneeImageView.image = viewModel.assignee?.profileURL 이미지다운
        self.assigneeID.text = viewModel.assignee?.userID
    }
}
