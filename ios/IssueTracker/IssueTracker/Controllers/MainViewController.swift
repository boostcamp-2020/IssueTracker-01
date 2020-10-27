//
//  MainViewController.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/10/27.
//

import UIKit

class MainViewController: UITabBarController {
    var userData: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkUserData()
    }
    
    private func configureLoginViewController() -> LoginViewController {
        return storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController ?? LoginViewController()
    }
    
    private func checkUserData() {
        guard userData == nil else { return }
        let login = configureLoginViewController()
        login.delegate = self
        login.modalPresentationStyle = .fullScreen
        present(login, animated: true, completion: nil)
    }
}

extension MainViewController: LoginViewControllerDelegate {
    func addUserData() {
        userData = "user"
    }
}
