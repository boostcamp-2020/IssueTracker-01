//
//  Milestone.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/09.
//

import Foundation

struct Milestone: Codable, Hashable {
    let milestoneID: Int?
    let title: String?
    let description: String?
    let dueDate: String?
    let openIssues: Int?
    let closeIssues: Int?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case milestoneID = "milestoneId"
        case dueDate
        case openIssues
        case closeIssues
        
    }
    
    init( title: String? = nil, dueDate: String? = nil, description: String? = nil) {
        self.milestoneID = nil
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.openIssues = nil
        self.closeIssues = nil
    }
}
