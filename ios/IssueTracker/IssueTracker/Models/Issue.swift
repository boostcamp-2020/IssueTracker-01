//
//  Issue.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/03.
//

import Foundation

struct IssueElements: Codable, Hashable {
    let issues: [Issue]

}

struct Issue: Codable, Hashable {
    var issueID: Int
    let title: String
    let milestoneTitle: String
}
