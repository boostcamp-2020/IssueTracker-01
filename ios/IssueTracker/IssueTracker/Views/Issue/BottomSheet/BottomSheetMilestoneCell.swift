//
//  BottomSheetMilestoneCell.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/12.
//

import UIKit

class BottomSheetMilestoneCell: UICollectionViewCell {
    @IBOutlet weak var milestoneTitle: UILabel!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var completedBar: UIView!

    func configureCell() {
        self.milestoneTitle.text = "스프린트1"
        let completeWidth = progressBar.frame.size.width * CGFloat((70)/100.0)
        completedBar.widthAnchor.constraint(equalToConstant: completeWidth).isActive = true
    }
}
