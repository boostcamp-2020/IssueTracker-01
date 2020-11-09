//
//  Issue.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/03.
//

import Foundation

struct Issue: Codable, Hashable {
    let title: String
    let issueID: Int
    let createdAt: String
    let isOpen: Int
    let userAuthor, user: User?
    let issueLabels: [IssueLabel]
    let milestoneTitle: Milestone?
    let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case title
        case issueID = "issueId"
        case createdAt, isOpen
        case userAuthor = "UserAuthor"
        case user = "User"
        case issueLabels = "IssueLabels"
        case milestoneTitle = "MileStone"
        case comments = "Comments"
    }
    
    static func == (lhs: Issue, rhs: Issue) -> Bool {
        lhs.issueID == rhs.issueID
    }
}
