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
        //FIXME: 라벨 설명을 받아오는 방법
        self.labelDescription.text = "라벨 설명"
    }
    
    override func prepareForReuse() {
        wrapperView.subviews.forEach{ $0.removeFromSuperview() }
    }
}
