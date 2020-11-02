//
//  IssueViewController.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/02.
//

import UIKit

class IssueViewController: UIViewController {
    private lazy var dataSource = makeDataSource()
    private var items: [Int] = [0, 1, 2]
    
    @IBOutlet weak var collectionView: UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
}

// MARK: - Storyboard identifier
extension IssueViewController {
    private struct StoryBoard {
        static let cell = "IssueMainCell"
        static let header = "IssueMainHeader"
    }
}

// MARK: - Configure CollectionView
extension IssueViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // TODO: - Action for click issue cell
    }
    
    private func configureCollectionView() {
        configureCell()
        configureFlowLayout()
        collectionView?.delegate = self
        collectionView?.dataSource = dataSource
        applySnapshot()
    }
    
    private func configureCell() {
        let name = "IssueCollectionViewCell"
        let nibName = UINib(nibName: name, bundle: nil)
        collectionView?.register(nibName, forCellWithReuseIdentifier: StoryBoard.cell)
    }
    
    private func configureFlowLayout() {
        guard let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.sectionHeadersPinToVisibleBounds = true
    }
}

// MARK: - UICollectionViewDiffableDataSource
extension IssueViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Int>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Int>
    
    private func makeDataSource() -> DataSource {
        guard let collectionView = collectionView else { return DataSource() }
        let dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, data) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryBoard.cell, for: indexPath)
            return cell
        })
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: StoryBoard.header, for: indexPath)
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
}
