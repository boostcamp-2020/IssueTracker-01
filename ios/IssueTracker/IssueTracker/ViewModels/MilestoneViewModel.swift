//
//  MilestoneViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/11.
//

import Foundation

class MilestoneViewModel {
    var milestoneCellViewModels = [MilestoneCellViewModel]() {
        didSet { milestoneChangeHandler?() }
    }
    
    var milestoneChangeHandler: (() -> Void)?
    var token: String?
    var networkManager: NetworkManager?
    
    init(token: String?, networkManager: NetworkManager?) {
        self.token = token
        self.networkManager = networkManager
    }
    
    func downloadData() {
        guard let token = token else { return }
        networkManager?.downloadMilestones(token: token) { [weak self] result in
            switch result {
            case let .success(result):
                self?.milestoneCellViewModels = result.map { MilestoneCellViewModel(milestone: $0) }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
