//
//  AlertManager.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/12.
//

import UIKit

class AlertManager {
    func showAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        
        return alert
    }
}
