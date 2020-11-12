//
//  MilestoneAlertViewController.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/12.
//

import UIKit

class MilestoneAlertViewController: UIViewController {
    @IBOutlet weak var milestoneTitle: UITextField!
    @IBOutlet weak var dueDate: UITextField!
    @IBOutlet weak var milestoneDescription: UITextField!
    
    weak var delegate: SnapshotDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize.height = 300
    }
    
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func save(_ sender: Any) {
        let alertManager = AlertManager()
        
        guard let title = milestoneTitle.text, title.count > 0 else {
            self.present(alertManager.showAlert(message: "제목을 입력해주세요."), animated: true)
            return
        }
        guard let dueDate = dueDate.text else { return }
        guard let description = milestoneDescription.text else { return }
        
        let newMilestone = Milestone(title: title, dueDate: dueDate, description: description)
        IssueTrackerNetworkManager.shared.addMilestone(milestone: newMilestone) { result in
            switch result {
            case let .success(result):
                self.delegate?.updateList()
                self.dismiss(animated: true, completion: nil)
            case let .failure(result):
                dump(result.localizedDescription)
                dump(result)
                self.present(alertManager.showAlert(message: "오류가 발생했습니다."), animated: true)
            }
        }
    }
    @IBAction func initialize(_ sender: Any) {
        milestoneTitle.text?.removeAll()
        dueDate.text?.removeAll()
        milestoneDescription.text?.removeAll()
    }
}
