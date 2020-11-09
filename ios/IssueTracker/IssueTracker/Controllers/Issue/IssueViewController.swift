//
//  IssueViewController.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/02.
//

import UIKit

class IssueViewController: UIViewController {
    private lazy var detailViewController = storyboard?.instantiateViewController(withIdentifier: ViewID.detail)
    private lazy var filterViewController = storyboard?.instantiateViewController(withIdentifier: ViewID.filter)
    
    private lazy var dataSource = makeDataSource()
    private var issueListViewModel = IssueListViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var filterButton: UIButton?
    @IBOutlet weak var editButton: UIButton?
    @IBOutlet weak var selectAllButton: UIButton?
    @IBOutlet weak var cancelButton: UIButton?
    @IBOutlet weak var addButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureCell()
        configureFlowLayout()
        applySnapshot()
    }
    
    func downloadViewModel() {
        self.issueListViewModel.delegate = self
        self.issueListViewModel.download()
    }
    
    @IBAction func clickEditButton(_ sender: UIButton) {
        setEditing(true, animated: true)
    }
    
    @IBAction func clickSelectAllButton(_ sender: Any) {
        selectAllCell()
    }
    
    @IBAction func clickCancelButton(_ sender: Any) {
        setEditing(false, animated: true)
    }
}

// MARK: - View identifier
extension IssueViewController {
    private struct ViewID {
        static let cell = String(describing: IssueCell.self)
        static let detail = String(describing: IssueDetailViewController.self)
        static let filter = String(describing: IssueFilterViewController.self)
    }
}

// MARK: - Configure CollectionView
extension IssueViewController: UICollectionViewDelegate {
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView?.isEditing = editing
        setButtonModes(isEditing: editing)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !isEditing else { return }
        guard let detail = detailViewController as? IssueDetailViewController else { return }
//        detail.downloadViewModel(issueID: 1)  값 넘겨주는 동작 필요
        navigationController?.pushViewController(detail, animated: true)
    }
    
    private func configureCollectionView() {
        collectionView?.delegate = self
        collectionView?.dataSource = dataSource
        collectionView?.allowsMultipleSelectionDuringEditing = true
    }
    
    private func configureCell() {
        let nibName = UINib(nibName: ViewID.cell, bundle: nil)
        collectionView?.register(nibName, forCellWithReuseIdentifier: ViewID.cell)
    }
    
    private func configureFlowLayout() {
        guard let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.sectionHeadersPinToVisibleBounds = true
        layout.itemSize.width = view.frame.width
    }
    
    private func setButtonModes(isEditing: Bool) {
        if isEditing {
            filterButton?.isHidden = true
            editButton?.isHidden = true
            selectAllButton?.isHidden = false
            cancelButton?.isHidden = false
            addButton?.isHidden = true
        } else {
            filterButton?.isHidden = false
            editButton?.isHidden = false
            selectAllButton?.isHidden = true
            cancelButton?.isHidden = true
            addButton?.isHidden = false
        }
        
        self.applySnapshot()
    }
    
    private func selectAllCell() {
        guard let size = collectionView?.numberOfItems(inSection: 0) else { return }
        (0..<size).forEach {
            collectionView?.selectItem(at: IndexPath(row: $0, section: 0), animated: false, scrollPosition: .init())
        }
    }
}

// MARK: - UICollectionViewDiffableDataSource
extension IssueViewController: SnapshotApplicable {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, IssueViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, IssueViewModel>
    
    private func makeDataSource() -> DataSource {
        guard let collectionView = collectionView else { return DataSource() }
        return DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, viewModel) -> IssueCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewID.cell, for: indexPath)
            guard let listCell = cell as? IssueCell else { return IssueCell() }
            self.binding(cell: listCell, issueViewModel: viewModel)
            return listCell
        })
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(issueListViewModel.items, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    private func binding(cell: IssueCell, issueViewModel: IssueViewModel) {
        cell.issueTitle?.text = issueViewModel.title
        cell.milestoneTitle?.text = issueViewModel.milestoneTitle?.title
        issueViewModel.configureLabel()
        guard let stackView = cell.badgeStackView else { return }
        issueViewModel.configureLabelStackView(stackView: stackView)
        
    }
}
