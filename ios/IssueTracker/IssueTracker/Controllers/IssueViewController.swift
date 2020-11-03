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
    @IBOutlet weak var leftTopButton: UIButton?
    @IBOutlet weak var rightTopButton: UIButton?
    @IBOutlet weak var addButton: UIButton?
    
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
  
    @IBAction func clickLeftTopButton(_ sender: UIButton) {
        if isEditing {
            selectAllCell()
        }
    }
    
    @IBAction func clickRightTopButton(_ sender: UIButton) {
        setEditing(!isEditing, animated: true)
    }
    
    @IBAction func clickAddButton(_ sender: UIButton) {
        
    }
}

// MARK: - Storyboard identifier
extension IssueViewController {
    private struct ViewID {
        static let cell = String(describing: IssueCell.self)
        static let detail = String(describing: IssueDetailViewController.self)
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
        guard let detail = storyboard?.instantiateViewController(withIdentifier: ViewID.detail) else { return }
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
            leftTopButton?.setTitle("SelectAll", for: .normal)
            rightTopButton?.setTitle("Cancel", for: .normal)
            addButton?.isHidden = true
        } else {
            leftTopButton?.setTitle("Filter", for: .normal)
            rightTopButton?.setTitle("Edit", for: .normal)
            addButton?.isHidden = false
        }
        
        collectionView?.reloadData()
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
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Int>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Int>
    
    private func makeDataSource() -> DataSource {
        guard let collectionView = collectionView else { return DataSource() }
        return DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, data) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewID.cell, for: indexPath)
            guard let listCell = cell as? IssueCell else { return cell }
            listCell.configureView(isEditing: self.isEditing)
            return listCell
        })
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
