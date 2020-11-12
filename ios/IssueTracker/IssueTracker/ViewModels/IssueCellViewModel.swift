//
//  IssueCellViewModel.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/10.
//

import Foundation

class IssueCellViewModel {
    let issueID: Int?
    let title: String
    let comments: [Comment]?
    let milestone: Milestone?
    let labelBadges: [LabelBadge]?
    let assignee: User?
    
    init(issue: Issue) {
        issueID = issue.issueID
        title = issue.title
        comments = issue.comments
        milestone = issue.milestone
        labelBadges = issue.issueLabels?.map {
            LabelBadge(text: $0.label.labelName, colorCode: $0.label.color)
        }
        assignee = issue.user
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
