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
        addViewModel.addIssueCompletion = { [weak self] in
            self?.downloadData()
        }
        return addViewModel
    }()
    
    lazy var issueFilterViewModel = IssueFilterViewModel(filtered: .open) { [weak self] in
        self?.downloadData()
    }
    
    private var issueCellViewModels = [IssueCellViewModel]() {
        didSet { issueChangeHandler?() }
    }
    
    var filteredIssueCellViewModels: [IssueCellViewModel] {
        guard let filterText = filterText, !filterText.isEmpty else { return issueCellViewModels }
        return issueCellViewModels.filter { $0.title.contains(filterText) }
    }
    
    var issueChangeHandler: (() -> Void)?
    var filterText: String?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func issueDetailViewModel(index: Int) throws -> IssueDetailViewModel {
        let issue = issueCellViewModels[index]
        guard let issueID = issue.issueID else { throw IssueViewModelError.noIssueID }
        return IssueDetailViewModel(comments: issue.comments ?? [], issueBottomSheetViewModel: IssueBottomSheetViewModel(issueID: issueID, networkManager: networkManager))
    }
    
    func downloadData() {
        switch issueFilterViewModel.filtered {
        case .open:
            self.downloadData(isOpen: true)
        case.close:
            self.downloadData(isOpen: false)
        }
    }
    
    private func downloadData(isOpen: Bool) {
        networkManager.downloadIssues(isOpen: isOpen) { [weak self] result in
            switch result {
            case let .success(result):
                self?.issueCellViewModels = result.map { IssueCellViewModel(issue: $0) }
            case let .failure(result):
                print(result.localizedDescription)
            }
        }
    }
}
