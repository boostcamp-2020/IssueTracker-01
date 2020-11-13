//
//  CommentViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/08.
//

import Foundation

class IssueDetailViewModel {
    let issueBottomSheetViewModel: IssueBottomSheetViewModel
    
    var commentCellViewModels = [CommentCellViewModel]() {
        didSet { itemSetHandler?() }
    }
    
    var networkManager: NetworkManager
    var issueID: Int
    var title: String?
    var userName: String
    var itemSetHandler: (() -> Void)?
    var userImageHandler: ((String) -> Void)?
    
    init(issueID: Int, title: String, userAuthor: User?, comments: [Comment], issueBottomSheetViewModel: IssueBottomSheetViewModel, networkManager: NetworkManager) {
        self.issueID = issueID
        self.title = title
        self.userName = userAuthor?.userID ?? "unknown"
        self.commentCellViewModels = comments.map { CommentCellViewModel(comment: $0) }
        self.issueBottomSheetViewModel = issueBottomSheetViewModel
        self.networkManager = networkManager
        configureUserImage(newValue: userAuthor?.profileURL)
    }
    
    private func configureUserImage(newValue: String?) {
        guard let userImage = newValue, let url = URL(string: userImage) else { return }
        networkManager.urlDataDownload(url) { [weak self] result in
            switch result {
            case let .success(result):
                self?.userImageHandler?(result)
            case let .failure(result):
                print(result.localizedDescription)
            }
        }
    }
}
