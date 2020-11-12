//
//  LabelAlertViewController.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/12.
//

import UIKit

class LabelAlertViewController: UIViewController {
    @IBOutlet weak var labelTitle: UITextField!
    @IBOutlet weak var labelDescription: UITextField!
    @IBOutlet weak var labelColor: UITextField!
    weak var delegate: LabelViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize.height = 300
    }
    
    @IBAction func exit(_ sender: Any) {
        delegate?.applySnapshot()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func save(_ sender: Any) {
        let alertManager = AlertManager()
        guard let title = labelTitle.text, title.count > 0 else {
            present(alertManager.showAlert(message: "제목을 입력해주세요."), animated: true)
            return
        }
        
        guard let description = labelDescription.text else { return }
        
        guard let color = labelColor.text, color.count > 0 else {
            present(alertManager.showAlert(message: "색상을 입력해주세요."), animated: true)
            return
        }
        
        let newLabel = Label(labelName: title, color: color, description: description)
        IssueTrackerNetworkManager.shared.addLabel(label: newLabel) { result in
            switch result {
            case .success(_):
                self.dismiss(animated: true, completion: nil)
            case .failure(_):
                self.present(alertManager.showAlert(message: "오류가 발생했습니다."), animated: true)
            }
        }
    }
    @IBAction func initialize(_ sender: Any) {
        self.labelTitle.text?.removeAll()
        self.labelDescription.text?.removeAll()
        self.labelColor.text?.removeAll()
    }
    
}
