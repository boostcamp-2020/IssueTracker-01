//
//  IssueBottomSheetViewModel.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/11.
//

import Foundation

class IssueBottomSheetViewModel {
    private let networkManager: NetworkManager
    
    var issueID: Int
    var closeIssueCompletion: (() -> Void)?
    
    init(issueID: Int, networkManager: NetworkManager) {
        self.issueID = issueID
        self.networkManager = networkManager
    }
    
    func closeIssue() {
        networkManager.closeIssue(issueID: issueID) { [weak self] result in
            switch result {
            case let .success(result):
                guard result.message == "success" else { print("error: ", result.message ?? ""); return }
                self?.closeIssueCompletion?()
            case let .failure(result):
                print(result.localizedDescription)
            }
        }
    }
}
