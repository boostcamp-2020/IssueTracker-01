//
//  MilestoneViewController.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/11.
//

import UIKit

class MilestoneViewController: UIViewController {
    private lazy var dataSource = makeDatasource()
    var viewModel: MilestoneViewModel?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkManager = IssueTrackerNetworkManager.shared.self
        let dummyVM = MilestoneViewModel(networkManager: networkManager)
        dummyVM.milestoneCellViewModels = [
            MilestoneCellViewModel(milestone: Milestone(title: "마일스톤1", dueDate: "20201111", description: "마일스톤설명1" )),
            MilestoneCellViewModel(milestone: Milestone(title: "마일스톤2", dueDate: "20201112", description: "마일스톤설명2")),
            MilestoneCellViewModel(milestone: Milestone(title: "마일스톤3", dueDate: "20201113", description: "마일스톤설명3")),
            MilestoneCellViewModel(milestone: Milestone(title: "마일스톤4", dueDate: "20201114", description: "마일스톤설명4" )),
            MilestoneCellViewModel(milestone: Milestone(title: "마일스톤5", dueDate: "20201115", description: "마일스톤설명5")),
            ]
        
        self.viewModel = dummyVM
        configureFlowLayout()
        applySnapshot()
    }

    @IBAction func addMilestone(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let contentVC = self.storyboard?.instantiateViewController(withIdentifier: "milestoneContentViewController")
        alert.setValue(contentVC, forKeyPath: "contentViewController")
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - View identifier
extension MilestoneViewController {
    private struct ViewID {
        static let cell = String(describing: MilestoneCell.self)
    }
}

extension MilestoneViewController {
    private func configureFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionHeadersPinToVisibleBounds = true
        flowLayout.itemSize = CGSize(width: self.view.frame.size.width, height: 80)
        flowLayout.minimumLineSpacing = 1
        
        self.collectionView.collectionViewLayout = flowLayout
        
    }
}

extension MilestoneViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, MilestoneCellViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, MilestoneCellViewModel>
    
    private func makeDatasource() -> DataSource {
        guard let collectionView = collectionView else { return DataSource() }
        return DataSource(collectionView: collectionView) { (collectionView, indexPath, viewModel) -> MilestoneCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewID.cell, for: indexPath)
            guard let listCell = cell as? MilestoneCell else { return MilestoneCell() }
            listCell.configureCell(viewModel: viewModel)
            
            return listCell
        }
    }
    
    func applySnapshot(animatingDiffernces: Bool = true) {
        guard let viewModel = viewModel else { return }
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.milestoneCellViewModels)
        dataSource.apply(snapshot, animatingDifferences: animatingDiffernces)
        
    }
    
}
