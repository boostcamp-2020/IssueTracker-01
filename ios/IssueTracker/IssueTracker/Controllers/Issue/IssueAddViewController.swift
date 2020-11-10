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
        
        //서버에서 받는 변수이름 : label
        //구조체 변수이름 : issueLabels (레이블 변수가 필수로 구현되어있음)
        
        guard let title = newIssueTitle?.text else { return }
        let newIssue = Issue(title: title)
        IssueTrackerNetworkManager.shared.createIssue(token: IssueTrackerGithubLoginManager.shared.token!, issue: newIssue) { result in
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
