//
//  IssueCell.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/02.
//

import UIKit

class IssueCell: UICollectionViewCell {
    @IBOutlet weak var issueTitle: UILabel?
    @IBOutlet weak var issueDescription: UILabel?
    @IBOutlet weak var milestoneTitle: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
