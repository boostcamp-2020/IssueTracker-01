//
//  LabelViewController.swift
//  IssueTracker
//
//  Created by 최광현 on 2020/11/10.
//

import UIKit

class LabelViewController: UIViewController {
    private lazy var dataSource = makeDatasource()
    var viewModel: LabelViewModel?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFlowLayout()
        applySnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let networkManager = IssueTrackerNetworkManager.shared.self
        self.viewModel = LabelViewModel(networkManager: networkManager)
        self.viewModel?.delegate = self
        self.viewModel?.downloadData()
    }

    @IBAction func addLabel(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        guard let contentVC = self.storyboard?.instantiateViewController(withIdentifier: "labelContentViewController") as? LabelAlertViewController else { return }
        contentVC.delegate = self
        alert.setValue(contentVC, forKeyPath: "contentViewController")
        
        self.present(alert, animated: true)
    }
}

// MARK: - View identifier
extension LabelViewController {
    private struct ViewID {
        static let cell = String(describing: LabelCell.self)
    }
}

extension LabelViewController {
    private func configureFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionHeadersPinToVisibleBounds = true
        flowLayout.itemSize = CGSize(width: self.view.frame.size.width, height: 80)
        flowLayout.minimumLineSpacing = 1
        
        self.collectionView.collectionViewLayout = flowLayout
        
    }
}

extension LabelViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, LabelCellViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, LabelCellViewModel>
    
    private func makeDatasource() -> DataSource {
        guard let collectionView = collectionView else { return DataSource() }
        return DataSource(collectionView: collectionView) { (collectionView, indexPath, viewModel) -> LabelCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewID.cell, for: indexPath)
            guard let listCell = cell as? LabelCell else { return LabelCell() }
            listCell.configureCell(viewModel: viewModel)
            
            return listCell
        }
    }
    
    func applySnapshot(animatingDiffernces: Bool = true) {
        guard let viewModel = viewModel else { return }
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.labelCellViewModels)
        dataSource.apply(snapshot, animatingDifferences: animatingDiffernces)
        
    }
    
}
