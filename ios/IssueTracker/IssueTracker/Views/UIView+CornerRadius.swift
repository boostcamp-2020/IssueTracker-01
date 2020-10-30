//
//  UIView+CornerRadius.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/10/27.
//

import UIKit

@IBDesignable
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
