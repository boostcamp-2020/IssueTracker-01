//
//  IssueViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/04.
//

import UIKit

class IssueViewModel {
    enum IssueViewModelError: Error {
        case noIssueID
    }
    
    let networkManager: NetworkManager
    
    lazy var issueAddViewModel: IssueAddViewModel = {
        let addViewModel = IssueAddViewModel(networkManager: self.networkManager)
        addViewModel.addIssueCompletion = {
            self.downloadData()
        }
        return addViewModel
    }()
    
    var issueCellViewModels = [IssueCellViewModel]() {
        didSet { issueChangeHandler?() }
    }
    
    var issueChangeHandler: (() -> Void)?
    var token: String?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func issueDetailViewModel(index: Int) throws -> IssueDetailViewModel {
        let issue = issueCellViewModels[index]
        guard let issueID = issue.issueID else { throw IssueViewModelError.noIssueID }
        return IssueDetailViewModel(comments: issue.comments ?? [], issueBottomSheetViewModel: IssueBottomSheetViewModel(issueID: issueID, networkManager: networkManager))
    }
    
    func downloadData() {
        networkManager.downloadIssues { [weak self] result in
            switch result {
            case let .success(result):
                self?.issueCellViewModels = result.map { IssueCellViewModel(issue: $0) }
            case let .failure(result):
                print(result.localizedDescription)
            }
        }
    }
}
