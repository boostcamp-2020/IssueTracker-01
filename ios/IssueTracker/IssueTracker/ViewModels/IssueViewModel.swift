//
//  IssueViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/04.
//

import UIKit

class IssueViewModel {
    var issueID: Int
    var title: String
    var milestoneTitle: MileStone?
    var issueLabels: [IssueLabel]?
    var labelBadges = [LabelBadge?]()
    
    init(issue: Issue) {
        self.issueID = issue.issueID
        self.title = issue.title
        self.milestoneTitle = issue.milestoneTitle
        self.issueLabels = issue.issueLabels
    }
    
    func configureLabel() {
        guard let labels = issueLabels else { return }
        for label in labels {
            guard let text = label.label?.labelName else { continue }
            guard let code = label.label?.color else { continue }
            let badge = LabelBadge(text: text, colorCode: code)
            labelBadges.append(badge)
        }
    }
    
    func configureLabelStackView(stackView: UIStackView) {
        stackView.distribution = .fillProportionally
        stackView.spacing = 3
        var sumOfLabelWidth = CGFloat.zero
        for badge in labelBadges {
            guard let badge = badge else { break }
            sumOfLabelWidth += badge.frame.size.width
            guard sumOfLabelWidth < stackView.frame.size.width else {
                badge.text = "..."
                stackView.addArrangedSubview(badge)
                badge.translatesAutoresizingMaskIntoConstraints = false
                badge.setContentHuggingPriority(.defaultLow, for: .horizontal)
                break
            }
            stackView.addArrangedSubview(badge)
        }
    }
}

extension IssueViewModel: Hashable {
    static func == (lhs: IssueViewModel, rhs: IssueViewModel) -> Bool {
        lhs.issueID == rhs.issueID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(issueID)
    }
}
