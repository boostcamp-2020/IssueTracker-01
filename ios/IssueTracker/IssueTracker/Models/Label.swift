//
//  Label.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/09.
//

import Foundation

struct Label: Codable, Hashable {
    let labelName: String
    let color: String
    let description: String?
    
    init(labelName: String, color: String, description: String? = nil) {
        self.labelName = labelName
        self.color = color
        self.description = description
    }
}
