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
    private lazy var addViewController = storyboard?.instantiateViewController(withIdentifier: ViewID.add)
    private lazy var searchController: UISearchController = {
        let search = UISearchController()
        search.searchBar.placeholder = "Search"
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        return search
    }()
    
    private lazy var dataSource = makeDataSource()
    
    var viewModel: IssueViewModel? {
        didSet {
            viewModel?.downloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var editingTabBar: UIToolbar?
    @IBOutlet weak var filterButton: UIButton?
    @IBOutlet weak var editButton: UIButton?
    @IBOutlet weak var selectAllButton: UIButton?
    @IBOutlet weak var cancelButton: UIButton?
    @IBOutlet weak var addButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        registerCell()
        configureFlowLayout()
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
    
    @IBAction func clickFilterButton(_ sender: Any) {
        guard let filter = filterViewController as? IssueFilterViewController else { return }
        guard let viewModel = viewModel else { return }
        filter.viewModel = viewModel.issueFilterViewModel
        let navigationViewController = UINavigationController(rootViewController: filter)
        navigationViewController.navigationBar.prefersLargeTitles = true
        navigationController?.present(navigationViewController, animated: true)
    }
    
    @IBAction func clickAddButton(_ sender: Any) {
        guard let add = addViewController as? IssueAddViewController else { return }
        guard let viewModel = viewModel else { return }
        add.viewModel = viewModel.issueAddViewModel
        let navigationViewController = UINavigationController(rootViewController: add)
        navigationViewController.navigationBar.prefersLargeTitles = true
        navigationController?.present(navigationViewController, animated: true)
    }
    
    @IBAction func clickCloseIssueButton(_ sender: Any) {
        guard let selectedItems = collectionView?.indexPathsForSelectedItems else { return }
        viewModel?.closeIssues(items: selectedItems.map { $0.row })
        viewModel?.downloadData()
        setEditing(false, animated: true)
    }
}

// MARK: - View identifier
extension IssueViewController {
    private struct ViewID {
        static let header = "IssueViewMainHeader"
        static let cell = String(describing: IssueCell.self)
        static let detail = String(describing: IssueDetailViewController.self)
        static let filter = String(describing: IssueFilterViewController.self)
        static let add = String(describing: IssueAddViewController.self)
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
        guard let viewModel = viewModel else { return }
        do {
            detail.viewModel = try viewModel.issueDetailViewModel(index: indexPath.row)
        } catch {
            print(error.localizedDescription)
        }
        navigationController?.pushViewController(detail, animated: true)
    }
    
    private func configureCollectionView() {
        collectionView?.delegate = self
        collectionView?.dataSource = dataSource
        collectionView?.allowsMultipleSelectionDuringEditing = true
        navigationItem.searchController = searchController
    }
    
    private func registerCell() {
        let nibName = UINib(nibName: ViewID.cell, bundle: nil)
        collectionView?.register(nibName, forCellWithReuseIdentifier: ViewID.cell)
    }
    
    private func configureFlowLayout() {
        guard let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.itemSize.width = view.frame.width
    }
    
    private func setButtonModes(isEditing: Bool) {
        filterButton?.isHidden = isEditing
        editButton?.isHidden = isEditing
        selectAllButton?.isHidden = !isEditing
        cancelButton?.isHidden = !isEditing
        addButton?.isHidden = isEditing
        editingTabBar?.isHidden = !isEditing
        tabBarController?.tabBar.isHidden = isEditing
    }
    
    private func selectAllCell() {
        guard let size = collectionView?.numberOfItems(inSection: 0) else { return }
        (0..<size).forEach {
            collectionView?.selectItem(at: IndexPath(row: $0, section: 0), animated: false, scrollPosition: .init())
        }
    }
}

// MARK: - UICollectionViewDiffableDataSource
extension IssueViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, IssueCellViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, IssueCellViewModel>
    
    private func makeDataSource() -> DataSource {
        guard let collectionView = collectionView else { return DataSource() }
        return DataSource(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, viewModel) -> IssueCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewID.cell, for: indexPath)
            guard let listCell = cell as? IssueCell else { return IssueCell() }
            guard let issueViewModel = self?.viewModel?.filteredIssueCellViewModels[indexPath.row] else { return listCell }
            listCell.configureCell(viewModel: issueViewModel)
            return listCell
        })
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        guard let viewModel = viewModel else { return }
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.filteredIssueCellViewModels, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

extension IssueViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel?.filterText = searchController.searchBar.text
        applySnapshot()
    }
}
