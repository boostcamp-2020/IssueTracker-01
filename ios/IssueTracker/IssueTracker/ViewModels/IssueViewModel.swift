//
//  IssueViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/03.
//

import Foundation

class IssueViewModel {
    
    var items: IssueElements?
    
    init() {
        configureDummy()
    }
    
    //Dummy - 네트워크에서 가져왔다고 가정
    func configureDummy() {
        let issue1 = Issue(issueID: 0, title: "제목1번", milestoneTitle: "mile1")
        let issue2 = Issue(issueID: 1, title: "제목2번", milestoneTitle: "mile2")
        items = IssueElements(issues: [issue1, issue2])
    }
    
}
