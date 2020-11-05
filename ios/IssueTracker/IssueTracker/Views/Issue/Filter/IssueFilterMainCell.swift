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
    lazy var outlineDisclosure = UICellAccessory.outlineDisclosure(displayed: .always, options: .init())
    
    private var isDetail = false
    override var isSelected: Bool {
        didSet {
            guard !isDetail else { return }
            if isSelected && accessories.count == 0 {
                accessories.append(selector)
            } else {
                accessories.removeAll()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSelectedBackgroundView()
    }
    
    private func configureSelectedBackgroundView() {
        let bgView = UIView(frame: bounds)
        bgView.backgroundColor = .systemBackground
        selectedBackgroundView = bgView
    }
    
    private func configureDetailCell() {
        accessories.removeAll()
        guard isDetail else { return }
        accessories.append(outlineDisclosure)
    }
    
    func configureView(title: String, isDetail: Bool) {
        titleLabel?.text = title
        guard self.isDetail != isDetail else { return }
        self.isDetail = isDetail
        configureDetailCell()
    }
}
