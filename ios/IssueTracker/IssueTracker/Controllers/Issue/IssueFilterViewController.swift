//
//  IssueFilterViewController.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/04.
//

import UIKit

class IssueFilterViewController: UIViewController {
    private lazy var dataSource = makeDataSource()
    private var items = ["열린 이슈들", "내가 작성한 이슈들", "나한테 할당된 이슈들", "내가 댓글을 남긴 이슈들", "닫힌 이슈들"]
    @IBOutlet weak var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureCell()
        configureFlowLayout()
        applySnapshot()
    }
}

// MARK: - View identifier
extension IssueFilterViewController {
    private struct ViewID {
        static let cell = String(describing: IssueFilterMainCell.self)
        static let header = "IssueFilterHeader"
    }
}

// MARK: - Configure CollectionView
extension IssueFilterViewController: UICollectionViewDelegate {
    private func configureCollectionView() {
        collectionView?.delegate = self
        collectionView?.allowsSelectionDuringEditing = true
        collectionView?.allowsSelection = true
    }
    
    private func configureCell() {
        let nibName = UINib(nibName: ViewID.cell, bundle: nil)
        collectionView?.register(nibName, forCellWithReuseIdentifier: ViewID.cell)
    }
    
    private func configureFlowLayout() {
        guard let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.itemSize.width = view.frame.width
    }
}

// MARK: - UICollectionViewDiffableDataSource
extension IssueFilterViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    private func makeDataSource() -> DataSource {
        guard let collectionView = collectionView else { return DataSource() }
        let dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, data) -> IssueFilterMainCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewID.cell, for: indexPath)
            guard let listCell = cell as? IssueFilterMainCell else { return IssueFilterMainCell() }
            listCell.configureView(title: data)
            listCell.indentsAccessories = true
            return listCell
        })
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ViewID.header, for: indexPath)
            return header
        }
        return dataSource
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    private func binding(cell: IssueCell, issue: Issue?) {
        cell.issueTitle?.text = issue?.title
        cell.milestoneTitle?.text = issue?.milestoneTitle
    }
}
