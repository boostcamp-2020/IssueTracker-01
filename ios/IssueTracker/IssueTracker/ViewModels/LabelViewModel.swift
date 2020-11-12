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
    
    weak var delegate: SnapshotDelegate?
    
    var labelChangeHandler: (() -> Void)?
    var networkManager: NetworkManager?
    
    init(networkManager: NetworkManager?) {
        self.networkManager = networkManager
    }
    
    func downloadData() {
        networkManager?.downloadLabels { [weak self] result in
            switch result {
            case let .success(result):
                let labelList = result.labels
                self?.labelCellViewModels = labelList?.map { LabelCellViewModel(label: $0) } ?? []
                self?.delegate?.applySnapshot(animatingDiffernces: true)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
