//
//  IssueAddViewController.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/05.
//

import UIKit

class IssueAddViewController: UIViewController {
    @IBOutlet weak var newIssueTitle: UITextField?
    @IBOutlet weak var newIssueContent: UITextView?
    
    var viewModel: IssueAddViewModel?
    
    @IBAction func clickExit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addIssue(_ sender: Any) {
        guard let title = newIssueTitle?.text else { return }
        viewModel?.addIssue(title: title) { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}
