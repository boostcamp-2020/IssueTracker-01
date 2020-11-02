//
//  UIColor+hexColor.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/02.
//

import Foundation
import UIKit

extension UIColor {
    static func hexColor(code: String) -> UIColor {
        let color = UIColor.gray
        guard let rgb = UInt(String(code.suffix(6)), radix: 16) else { return color  }
         
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
