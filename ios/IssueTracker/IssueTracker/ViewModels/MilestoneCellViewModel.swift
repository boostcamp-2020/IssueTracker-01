//
//  MilestoneCellViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/11.
//

import Foundation

class MilestoneCellViewModel {
    let milestoneID: Int?
    let title: String?
    let description: String?
    let dueDate: String?
    let openIssues: Int?
    let closeIssues: Int?
    
    init(milestone: Milestone) {
        self.milestoneID = milestone.milestoneID
        self.title = milestone.title
        self.description = milestone.description
        self.dueDate = milestone.dueDate
        self.openIssues = milestone.openIssues
        self.closeIssues = milestone.closeIssues
    }
    
    func calcPercentage() -> Int {
        guard let close = self.closeIssues, close != 0 else { return 0 }
        guard let open = self.openIssues, open != 0  else { return 100 }
        
        return close / (open + close) * 100
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
