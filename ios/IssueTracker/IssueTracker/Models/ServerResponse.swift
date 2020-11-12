//
//  ServerResponse.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/11.
//

import Foundation

struct ServerResponse: Codable {
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}
