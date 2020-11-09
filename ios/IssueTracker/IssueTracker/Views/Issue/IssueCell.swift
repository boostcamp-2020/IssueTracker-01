//
//  IssueCell.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/02.
//

import UIKit

class IssueCell: UICollectionViewListCell {
    @IBOutlet weak var issueTitle: UILabel?
    @IBOutlet weak var issueDescription: UILabel?
    @IBOutlet weak var milestoneTitle: UILabel?
    @IBOutlet weak var badgeStackView: UIStackView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSelectedBackgroundView()
        configureMultiselect()
    }
    
    override func prepareForReuse() {
        badgeStackView = nil
    }
    
    private func configureSelectedBackgroundView() {
        let bgView = UIView(frame: bounds)
        bgView.backgroundColor = .systemBackground
        selectedBackgroundView = bgView
    }
    
    private func configureMultiselect() {
        let selector = UICellAccessory.multiselect(displayed: .whenEditing, options: .init())
        accessories.append(selector)
        guard let issueTitle = issueTitle, let issueDescription = issueDescription else { return }
        separatorLayoutGuide.trailingAnchor.constraint(equalTo: issueTitle.leadingAnchor).isActive = true
        separatorLayoutGuide.trailingAnchor.constraint(equalTo: issueDescription.leadingAnchor).isActive = true
    }
    
    private func configureLabelStackView(labelBadges: [LabelBadge]) {
        guard let stackView = badgeStackView else { return }
        stackView.distribution = .fillProportionally
        stackView.spacing = 3
        
        var sumOfLabelWidth = CGFloat.zero
        labelBadges.forEach { badge in
            sumOfLabelWidth += badge.frame.size.width
            guard sumOfLabelWidth > stackView.frame.size.width else { return }
            badge.text = "..."
            badge.translatesAutoresizingMaskIntoConstraints = false
            badge.setContentHuggingPriority(.defaultLow, for: .horizontal)
            stackView.addArrangedSubview(badge)
        }
    }
    
    func configureCell(issueViewModel: IssueCellViewModel) {
        issueTitle?.text = issueViewModel.title
        milestoneTitle?.text = issueViewModel.milestone?.title
        configureLabelStackView(labelBadges: issueViewModel.labelBadges)
    }
}
