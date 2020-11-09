//
//  Comment.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/09.
//

import Foundation

struct Comment: Codable, Hashable {
    let commentID: Int
    let userID: String

    enum CodingKeys: String, CodingKey {
        case commentID = "commentId"
        case userID = "userId"
    }
}
