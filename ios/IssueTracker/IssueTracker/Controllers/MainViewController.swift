//
//  MainViewController.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/10/27.
//

import UIKit

class MainViewController: UITabBarController {
    var accessToken: String?
    var githubLogin: GithubLogin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAccessToken()
    }
    
    private func configureLoginViewController() -> LoginViewController {
        let login = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController ?? LoginViewController()
        login.delegate = self
        return login
    }
    
    private func checkAccessToken() {
        guard accessToken == nil else { return }
        let login = configureLoginViewController()
        login.delegate = self
        login.modalPresentationStyle = .fullScreen
        present(login, animated: true, completion: nil)
    }
}

extension MainViewController: LoginViewControllerDelegate {
    func requestCode(loginViewController: LoginViewController) {
        githubLogin?.requestCode { result in
            switch result {
            case let .success(token):
                self.accessToken = token
                loginViewController.dismiss(animated: true, completion: nil)
            case let .failure(error):
                print("error: ", error)
            }
        }
    }
}
