//
//  IssueFilterViewController.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/04.
//

import UIKit

class IssueFilterViewController: UIViewController {
    private lazy var dataSource = makeDataSource()
    @IBOutlet weak var collectionView: UICollectionView?
    
    var viewModel: IssueFilterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureCell()
        configureFlowLayout()
        applySnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectFilterCell()
    }
    
    @IBAction func clickDoneButton(_ sender: Any) {
        guard let selected = collectionView?.indexPathsForSelectedItems?.first?.row else { return }
        viewModel?.applyFilter(selected)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - View identifier
extension IssueFilterViewController {
    private struct ViewID {
        static let cell = String(describing: IssueFilterMainCell.self)
        static let header = String(describing: IssueFilterHeader.self)
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
    
    private func selectFilterCell() {
        guard let collectionView = collectionView else { return }
        guard let viewModel = viewModel else {
            let selectedIndexPath = IndexPath(row: 0, section: 0)
            collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .top)
            return
        }
        let selectedIndexPath = IndexPath(row: viewModel.filtered.rawValue, section: 0)
        guard let selectedItems = collectionView.indexPathsForSelectedItems,
              !selectedItems.isEmpty,
              selectedItems.contains(selectedIndexPath) else {
            collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .top)
            return
        }
    }
}

// MARK: - UICollectionViewDiffableDataSource
extension IssueFilterViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<String, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<String, String>
    
    private func makeDataSource() -> DataSource {
        guard let collectionView = collectionView else { return DataSource() }
        let dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, data) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewID.cell, for: indexPath)
            guard let filterCell = cell as? IssueFilterMainCell else { return cell }
            filterCell.configureView(title: data, isDetail: indexPath.section == 1)
            filterCell.indentsAccessories = true
            return filterCell
        })
        
        dataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) -> UICollectionReusableView? in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ViewID.header, for: indexPath)
            guard let filterHeader = header as? IssueFilterHeader else { return header }
            filterHeader.configureView(title: self?.viewModel?.sectionTitles[indexPath.section] ?? "")
            return filterHeader
        }
        return dataSource
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        let sectionTitles = viewModel?.sectionTitles ?? []
        let items = viewModel?.items ?? []
        snapshot.appendSections(sectionTitles)
        (0..<sectionTitles.count).forEach {
            snapshot.appendItems(items[$0], toSection: sectionTitles[$0])
        }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    private func binding(cell: IssueCell, issue: Issue?) {
        cell.issueTitle?.text = issue?.title
        cell.milestoneTitle?.text = issue?.milestone?.title
    }
}
