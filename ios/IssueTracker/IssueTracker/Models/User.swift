//
//  User.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/09.
//

import Foundation

struct User: Codable, Hashable {
    let userID, profileURL: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case profileURL = "profile_url"
    }
}
