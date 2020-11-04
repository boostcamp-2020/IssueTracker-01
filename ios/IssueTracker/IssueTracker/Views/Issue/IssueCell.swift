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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indentsAccessories = true
        configureMultiselect()
    }
    
    private func configureMultiselect() {
        let selector = UICellAccessory.multiselect(displayed: .whenEditing, options: .init())
        accessories.append(selector)
        separatorLayoutGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    }
}
