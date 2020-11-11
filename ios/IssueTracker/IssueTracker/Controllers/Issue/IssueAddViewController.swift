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
    
    @IBAction func addIssue(_ sender: Any) {
        guard let title = newIssueTitle?.text else { return }
        let newIssue = Issue(title: title)
        IssueTrackerNetworkManager.shared.addIssue(issue: newIssue) { result in
            switch result {
            case let .success(result):
                print("success")
                //뷰 내리고 이슈 목록 다시 받아오기
            case let .failure(result):
                print(result.localizedDescription)
            }
        }
    }
}
