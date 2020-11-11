//
//  MilestoneCell.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/11.
//

import UIKit

class MilestoneCell: UICollectionViewCell {
    @IBOutlet weak var milestoneTitle: UILabel!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var completedBar: UIView!
    
    func configureCell() {
        //dummy
        self.milestoneTitle.text = "스프린트1"
        let completeWidth = progressBar.frame.size.width * CGFloat((70)/100.0)
        completedBar.widthAnchor.constraint(equalToConstant: completeWidth).isActive = true
    }
}
