//
//  Label.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/09.
//

import Foundation

struct Label: Codable {
    let labelName, color: String
}

struct IssueLabel: Codable {
    let labelID: Int
    let label: Label

    enum CodingKeys: String, CodingKey {
        case labelID = "id"
        case label = "Label"
    }
}
