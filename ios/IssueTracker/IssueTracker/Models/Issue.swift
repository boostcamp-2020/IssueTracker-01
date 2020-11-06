//
//  Issue.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/03.
//

import Foundation

struct IssueElement: Codable {
    let issues: [Issue]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        issues = try container.decode([Issue].self)
    }
}

struct Issue: Codable {
    let title: String
    let issueID: Int
    let createdAt: String
    let isOpen: Int
    let userAuthor, user: User?
    let issueLabels: [IssueLabel]
    let milestoneTitle: MileStone?
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
}

struct Comment: Codable {
    let commentID: Int
    let userID: String

    enum CodingKeys: String, CodingKey {
        case commentID = "commentId"
        case userID = "userId"
    }
}

struct IssueLabel: Codable {
    let labelID: Int
    let label: Label

    enum CodingKeys: String, CodingKey {
        case labelID = "id"
        case label = "Label"
    }
}

struct Label: Codable {
    let labelName, color: String
}

struct MileStone: Codable {
    let title: String
}

struct User: Codable {
    let userID, profileURL: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case profileURL = "profile_url"
    }
}
