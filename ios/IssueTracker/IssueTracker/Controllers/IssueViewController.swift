//
//  IssueViewController.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/02.
//

import UIKit

class IssueViewController: UIViewController {
    private lazy var dataSource = makeDataSource()
    private var items: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    
    @IBOutlet weak var collectionView: UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureCell()
        configureFlowLayout()
        applySnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - Storyboard identifier
extension IssueViewController {
    private struct ViewID {
        static let cell = "IssueMainCell"
        static let detail = String(describing: IssueDetailViewController.self)
    }
}

// MARK: - Configure CollectionView
extension IssueViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detail = storyboard?.instantiateViewController(withIdentifier: ViewID.detail) else { return }
        navigationController?.pushViewController(detail, animated: true)
    }
    
    private func configureCollectionView() {
        collectionView?.delegate = self
        collectionView?.dataSource = dataSource
    }
    
    private func configureCell() {
        let name = String(describing: IssueCell.self)
        let nibName = UINib(nibName: name, bundle: nil)
        collectionView?.register(nibName, forCellWithReuseIdentifier: ViewID.cell)
    }
    
    private func configureFlowLayout() {
        guard let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.sectionHeadersPinToVisibleBounds = true
        layout.itemSize.width = view.frame.width
    }
}

// MARK: - UICollectionViewDiffableDataSource
extension IssueViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Int>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Int>
    
    private func makeDataSource() -> DataSource {
        guard let collectionView = collectionView else { return DataSource() }
        return DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, data) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewID.cell, for: indexPath)
            return cell
        })
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
