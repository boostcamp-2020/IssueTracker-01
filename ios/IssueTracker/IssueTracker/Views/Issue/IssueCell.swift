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
    
    private func configureSelectedBackgroundView() {
        let bgView = UIView(frame: bounds)
        bgView.backgroundColor = .systemBackground
        selectedBackgroundView = bgView
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        badgeStackView?.arrangedSubviews.forEach { $0.removeFromSuperview() }
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
            stackView.addArrangedSubview(badge)
            guard sumOfLabelWidth > stackView.frame.size.width else { return }
            badge.backgroundColor = .clear
            badge.text = "..."
        }
    }
    
    func configureCell(viewModel: IssueCellViewModel) {
        issueTitle?.text = viewModel.title
        milestoneTitle?.text = viewModel.milestone?.title
        configureLabelStackView(labelBadges: viewModel.labelBadges)
    }
}
