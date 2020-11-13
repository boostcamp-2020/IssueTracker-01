//
//  LabelBadge.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/02.
//

import UIKit

class LabelBadge: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(origin: CGPoint = CGPoint.zero, text: String, colorCode: String) {
        self.init(frame: CGRect(origin: origin, size: CGSize(width: 0, height: 0) ) )
        configure(origin: origin, text: text, colorCode: colorCode)
    }
    
    convenience init(label: Label) {
        self.init(frame: CGRect(origin: CGPoint.zero, size: CGSize.zero))
        configure(origin: CGPoint.zero, text: label.labelName, colorCode: label.color)
    }
    
    func configure(origin: CGPoint, text: String, colorCode: String) {
        self.text = text
        self.backgroundColor = UIColor.hexColor(code: colorCode)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 7
        
        self.font = self.font.withSize(14)
        self.textAlignment = .center
        
        self.sizeToFit()
        let newSize = self.sizeThatFits(self.frame.size)
        
        self.frame.size.width = newSize.width + 20
        self.frame.size.height = 20
    }
}
