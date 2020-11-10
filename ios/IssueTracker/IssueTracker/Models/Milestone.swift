//
//  Milestone.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/09.
//

import Foundation

struct Milestone: Codable, Hashable {
    let title: String?
    let milestoneID: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case milestoneID = "milestoneId"
    }
    
    init(milestoneID: Int, title: String? = nil) {
        self.title = title
        self.milestoneID = milestoneID
    }
}
