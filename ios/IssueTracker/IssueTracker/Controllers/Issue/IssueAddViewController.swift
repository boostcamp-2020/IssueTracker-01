//
//  IssueAddViewController.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/05.
//

import UIKit

class IssueAddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func clickExit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
