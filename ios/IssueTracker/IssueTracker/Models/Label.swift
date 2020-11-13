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

struct LabelList: Codable {
    let labels: [Label]?
    
    enum CodingKeys: String, CodingKey {        
        case labels = "data"
    }
}

struct LabelResult: Codable {
    let data: Label
    let message: String
}

struct LabelParameter: Codable {
    let labelName: String
    let color: String
    let desc: String?
    
    init(label: Label) {
        self.labelName = label.labelName
        self.color = label.color
        self.desc = label.description
    }
}
