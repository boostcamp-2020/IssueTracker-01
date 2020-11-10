//
//  LabelViewModel.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/10.
//

import Foundation

class LabelViewModel {
    var labelCellViewModels = [LabelCellViewModel]() {
        didSet { labelChangeHandler?() }
    }
    
    var labelChangeHandler: (() -> Void)?
    var token: String?
    var networkManager: NetworkManager?
    
    init(token: String?, networkManager: NetworkManager?) {
        self.token = token
        self.networkManager = networkManager
    }
    
    func downloadData() {
        guard let token = token else { return }
        networkManager?.downloadLabels(token: token) { [weak self] result in
            switch result {
            case let .success(result):
                self?.labelCellViewModels = result.map { LabelCellViewModel(label: $0) }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
