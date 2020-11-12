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

        configureFlowLayout()
        applySnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel = MilestoneViewModel(networkManager: IssueTrackerNetworkManager.shared.self)
        self.viewModel?.delegate = self
        self.viewModel?.downloadData()
        
    }

    @IBAction func addMilestone(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        guard let contentVC = self.storyboard?.instantiateViewController(withIdentifier: "milestoneContentViewController") as? MilestoneAlertViewController else { return }
        contentVC.delegate = self
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

extension MilestoneViewController: SnapshotDelegate {
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
