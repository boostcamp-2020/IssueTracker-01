//
//  LabelCellViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/10.
//

import Foundation

class LabelCellViewModel {
    let labelName: String
    let color: String
    init(label: Label) {
        self.labelName = label.labelName
        self.color = label.color
    }
}

extension LabelCellViewModel: Hashable {
    static func == (lhs: LabelCellViewModel, rhs: LabelCellViewModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(labelName)
        hasher.combine(color)
    }
}
