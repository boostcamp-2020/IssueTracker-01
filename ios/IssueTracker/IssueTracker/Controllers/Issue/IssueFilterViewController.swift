//
//  IssueFilterViewController.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/04.
//

import UIKit

class IssueFilterViewController: UIViewController {
    private lazy var dataSource = makeDataSource()
    private var items = [["열린 이슈들", "내가 작성한 이슈들", "나한테 할당된 이슈들", "내가 댓글을 남긴 이슈들", "닫힌 이슈들"],
                         ["작성자", "레이블", "마일스톤", "담당자"]]
    private var sectionTitles = ["다음 중에 조건을 고르세요", "세부 조건"]
    @IBOutlet weak var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureCell()
        configureFlowLayout()
        applySnapshot()
    }
    
    @IBAction func clickExit(_ sender: Any) {
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
            filterCell.configureView(title: data)
            filterCell.indentsAccessories = true
            return filterCell
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ViewID.header, for: indexPath)
            guard let filterHeader = header as? IssueFilterHeader else { return header }
            filterHeader.configureView(title: self.sectionTitles[indexPath.section])
            return filterHeader
        }
        return dataSource
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(sectionTitles)
        (0...1).forEach {
            snapshot.appendItems(items[$0], toSection: sectionTitles[$0])
        }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    private func binding(cell: IssueCell, issue: Issue?) {
        cell.issueTitle?.text = issue?.title
        cell.milestoneTitle?.text = issue?.milestoneTitle.title
    }
}
