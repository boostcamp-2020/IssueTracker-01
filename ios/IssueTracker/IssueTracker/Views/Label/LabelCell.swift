//
//  LabelCell.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/10.
//

import UIKit

class LabelCell: UICollectionViewListCell {
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var labelDescription: UILabel!
    
    func configureCell(viewModel: LabelCellViewModel) {
        let badge = LabelBadge(text: viewModel.labelName, colorCode: viewModel.color)
        self.wrapperView.addSubview(badge)
        self.labelDescription.text = viewModel.labelDescription
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        wrapperView.subviews.forEach { $0.removeFromSuperview() }
    }
}
