//
//  CommentViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/08.
//

import UIKit

class CommentViewModel {
    var commentID: Int
    var userID: String?
    var content: String?
    var createdAt: String?
    var user: User?
    
    init(comment: Comment) {
        self.commentID = comment.commentID
        self.userID = comment.userID
        self.content = comment.content
        self.createdAt = comment.createdAt
        self.user = comment.user
    }
    
    func configureDate() -> String {
        guard let dateString = createdAt else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        if let date = formatter.date(from: dateString) {
            let relativeFormatter = RelativeDateTimeFormatter()
            relativeFormatter.locale = Locale.init(identifier: "ko_KR")
            relativeFormatter.unitsStyle = .full
            let relativeDate = relativeFormatter.localizedString(for: date, relativeTo: Date())
            return relativeDate
        }
        return ""
    }
    
}

extension CommentViewModel: Hashable {
    static func == (lhs: CommentViewModel, rhs: CommentViewModel) -> Bool {
        lhs.commentID == rhs.commentID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(commentID)
    }
}
