//
//  MilestoneCellViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/11.
//

import Foundation

class MilestoneCellViewModel {
    let title: String?
    let milestoneID: Int
    init(milestone: Milestone) {
        self.title = milestone.title
        self.milestoneID = milestone.milestoneID
    }
}

extension MilestoneCellViewModel: Hashable {
    static func == ( lhs: MilestoneCellViewModel, rhs: MilestoneCellViewModel ) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(milestoneID)
    }
}
