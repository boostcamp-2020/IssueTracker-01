//
//  LabelAlertViewController.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/12.
//

import UIKit

class LabelAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: 300, height: 300)
    }
    
    
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func save(_ sender: Any) {
        
        
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func initialize(_ sender: Any) {
    }
    
    
}
