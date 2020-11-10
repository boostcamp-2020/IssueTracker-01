//
//  MilestoneCell.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/11.
//

import UIKit

class MilestoneCell: UICollectionViewListCell {
    @IBOutlet weak var milestoneTitle: UILabel!
    @IBOutlet weak var milestoneDescription: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var percentage: UILabel!
    @IBOutlet weak var openedIssue: UILabel!
    @IBOutlet weak var closedIssue: UILabel!
    
    func configureCell(viewModel: MilestoneCellViewModel) {
        self.milestoneTitle.text = viewModel.title
        self.milestoneDescription.text = "마일스톤 설명"
    }
}
