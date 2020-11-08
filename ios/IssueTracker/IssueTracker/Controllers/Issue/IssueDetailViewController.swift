//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/03.
//

import UIKit

class IssueDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension IssueDetailViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, IssueViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, IssueViewModel>
    
    private func makeDataSource() -> DataSource {
        guard let collectionView = collectionView else { return DataSource() }
        return DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, commentViewModel) -> CommentCollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "commentCell", for: indexPath)
            guard let listCell = cell as? CommentCollectionViewCell else { return CommentCollectionViewCell() }
//            self.binding(cell: listCell, issueViewModel: viewModel)
            return listCell
        })
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
//        snapshot.appendItems(issueListViewModel.items, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
//    func binding(cell: CommentCollectionViewCell, commentViewModel: CommentViewModel) {
//
//    }
    
}
