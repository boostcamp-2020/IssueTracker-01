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
    
    @IBOutlet weak var badgeStackView: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureMultiselect()
    }
    
    private func configureMultiselect() {
        let selector = UICellAccessory.multiselect(displayed: .whenEditing, options: .init())
        accessories.append(selector)
        guard let issueTitle = issueTitle, let issueDescription = issueDescription else { return }
        separatorLayoutGuide.trailingAnchor.constraint(equalTo: issueTitle.leadingAnchor).isActive = true
        separatorLayoutGuide.trailingAnchor.constraint(equalTo: issueDescription.leadingAnchor).isActive = true
    }
}
