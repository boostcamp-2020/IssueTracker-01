//
//  IssueFilterMainCell.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/04.
//

import UIKit

class IssueFilterMainCell: UICollectionViewListCell {

    @IBOutlet weak var titleLabel: UILabel?
    lazy var selector = UICellAccessory.checkmark(displayed: .always, options: .init())
    
    override var isSelected: Bool {
        didSet {
            if isSelected && accessories.count == 0 {
                accessories.append(selector)
            } else {
                accessories.removeAll()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureView(title: String) {
        titleLabel?.text = title
    }
}
