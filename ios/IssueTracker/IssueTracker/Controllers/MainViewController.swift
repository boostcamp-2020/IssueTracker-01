//
//  MainViewController.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/10/27.
//

import UIKit

class MainViewController: UITabBarController {
    lazy var loginViewController: LoginViewController = {
        let login = storyboard?.instantiateViewController(withIdentifier: ViewID.login) as? LoginViewController ?? LoginViewController()
        login.delegate = self
        login.modalPresentationStyle = .fullScreen
        return login
    }()
    
    var githubLoginManager: GithubLoginManager?
    var networkManager: NetworkManager?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAccessToken()
    }
    
    private func checkAccessToken() {
        guard githubLoginManager?.token == nil else { return }
        present(loginViewController, animated: true, completion: nil)
    }
}

// MARK: - View identifier
extension MainViewController {
    private struct ViewID {
        static let login = String(describing: LoginViewController.self)
    }
}

// MARK: - LoginViewControllerDelegate
extension MainViewController: LoginViewControllerDelegate {
    func requestCode(loginViewController: LoginViewController) {
        githubLoginManager?.requestGithubLogin { [weak self] in
            loginViewController.dismiss(animated: true, completion: nil)
            guard let navigation = self?.viewControllers?.first as? UINavigationController else { return }
            guard let issue = navigation.viewControllers.first as? IssueViewController else { return }
            let issueViewModel = IssueViewModel(token: self?.githubLoginManager?.token, networkManager: self?.networkManager)
            issueViewModel.itemSetHandler = { issue.applySnapshot() }
            issue.viewModel = issueViewModel
        }
    }
}
