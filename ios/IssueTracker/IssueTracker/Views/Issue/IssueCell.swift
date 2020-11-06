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
    
    private func configureMultiselect() {
        let selector = UICellAccessory.multiselect(displayed: .whenEditing, options: .init())
        accessories.append(selector)
        guard let issueTitle = issueTitle, let issueDescription = issueDescription else { return }
        separatorLayoutGuide.trailingAnchor.constraint(equalTo: issueTitle.leadingAnchor).isActive = true
        separatorLayoutGuide.trailingAnchor.constraint(equalTo: issueDescription.leadingAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        self.badgeStackView = nil
    }
}
