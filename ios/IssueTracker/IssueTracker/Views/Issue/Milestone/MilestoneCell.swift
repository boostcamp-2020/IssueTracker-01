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
        self.milestoneDescription.text = viewModel.description
        self.dueDate.text = viewModel.formatDueDate()
        self.percentage.text = "\(viewModel.calcPercentage())%"
        self.openedIssue.text = "\(viewModel.openIssues ?? 0) opened"
        self.closedIssue.text = "\(viewModel.closeIssues ?? 0) closed"

    }
}
