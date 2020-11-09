//
//  IssueCellViewModel.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/10.
//

import Foundation

class IssueCellViewModel {
    let issueID: Int
    let title: String
    let milestone: Milestone?
    let labelBadges: [LabelBadge]
    
    init(issue: Issue) {
        issueID = issue.issueID
        title = issue.title
        milestone = issue.milestoneTitle
        labelBadges = issue.issueLabels.map {
            LabelBadge(text: $0.label.labelName, colorCode: $0.label.color)
        }
    }
}

extension IssueCellViewModel: Hashable {
    static func == (lhs: IssueCellViewModel, rhs: IssueCellViewModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(issueID)
        hasher.combine(title)
        hasher.combine(milestone)
        hasher.combine(labelBadges)
    }
}
