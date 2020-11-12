//
//  IssueLabel.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/09.
//

import Foundation

struct IssueLabel: Codable, Hashable {
    let labelID: Int
    let label: Label

    enum CodingKeys: String, CodingKey {
        case labelID = "id"
        case label = "Label"
    }
}
