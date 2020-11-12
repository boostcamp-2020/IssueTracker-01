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
    
    func formatDueDate() -> String {
        guard let dateString = dueDate else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        guard let date = formatter.date(from: dateString) else { return "" }
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
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
