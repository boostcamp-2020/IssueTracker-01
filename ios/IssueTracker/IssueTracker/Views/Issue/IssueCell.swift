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
    
    @IBOutlet weak var defaultConstraint: NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureMultiselect()
    }
    
    private func configureMultiselect() {
        let selector = UICellAccessory.multiselect(displayed: .whenEditing, options: .init())
        accessories.append(selector)
    }
    
    func configureView(isEditing: Bool) {
        configureEditing(isEditing: isEditing)
    }
    
    private func configureEditing(isEditing: Bool) {
        defaultConstraint?.isActive = !isEditing
    }
}
