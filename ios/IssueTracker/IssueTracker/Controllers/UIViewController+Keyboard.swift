//
//  UIViewController+Keyboard.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/02.
//

import UIKit

extension UIViewController {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
