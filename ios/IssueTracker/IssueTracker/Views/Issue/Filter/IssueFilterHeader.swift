//
//  IssueFilterHeader.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/05.
//

import UIKit

class IssueFilterHeader: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureView(title: String) {
        titleLabel?.text = title
    }
}
