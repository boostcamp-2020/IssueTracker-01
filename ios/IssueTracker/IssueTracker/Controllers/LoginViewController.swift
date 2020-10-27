//
//  LoginViewController.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/10/27.
//

import UIKit

protocol LoginViewControllerDelegate {
    func addUserData()
}

class LoginViewController: UIViewController {
    var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func configureMainTabBarController() -> UIViewController {
        return storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") ?? UIViewController()
    }
    
    private func gitHubOAuth() -> Any? {
        return "user"
    }
    
    @IBAction func loginGitHub(_ sender: UIButton) {
        guard let oAuth = gitHubOAuth() else { return }
        delegate?.addUserData()
        dismiss(animated: true)
    }
}
