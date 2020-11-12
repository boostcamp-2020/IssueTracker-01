//
//  IssueFilterViewModel.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/12.
//

import Foundation

class IssueFilterViewModel {
    enum MainFilter: Int {
        case open, close
    }
    
    var items = [["열린 이슈들", "닫힌 이슈들"]]
    var sectionTitles = ["다음 중에 조건을 고르세요"]
    var filtered: MainFilter
    var filterChangeHandler: (() -> Void)?
    
    init(filtered: MainFilter, filterChangeHandler: (() -> Void)?) {
        self.filtered = filtered
        self.filterChangeHandler = filterChangeHandler
    }
    
    func applyFilter(_ select: Int) {
        guard filtered.rawValue != select else { return }
        filtered = MainFilter(rawValue: select) ?? .open
        filterChangeHandler?()
    }
}
