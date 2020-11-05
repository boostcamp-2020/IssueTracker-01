//
//  LoginViewController.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/10/27.
//

import UIKit

protocol LoginViewControllerDelegate: class {
    func requestCode(loginViewController: LoginViewController)
}

class LoginViewController: UIViewController {
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureMainTabBarController() -> UIViewController {
        return storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") ?? UIViewController()
    }
    
    private func gitHubOAuth() -> Any? {
        return "user"
    }
    
    @IBAction func loginGitHub(_ sender: UIButton) {
        delegate?.requestCode(loginViewController: self)
    }
}
