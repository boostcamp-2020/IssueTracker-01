//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/03.
//

import UIKit

class IssueDetailViewController: UIViewController {
    private lazy var bottomSheetViewController: IssueBottomSheetViewController = {
        guard let bottom = storyboard?.instantiateViewController(withIdentifier: ViewID.bottomView) as? IssueBottomSheetViewController else { return IssueBottomSheetViewController() }
        return bottom
    }()
    private lazy var dataSource = makeDataSource()
    
    @IBOutlet weak var collectionView: UICollectionView?
    
    var viewModel: CommentViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        registerCell()
        configureFlowLayout()
        applySnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureBottomSheetView()
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - View identifier
extension IssueDetailViewController {
    private struct ViewID {
        static let cell = String(describing: IssueCommentCell.self)
        static let bottomView = String(describing: IssueBottomSheetViewController.self)
    }
}

// MARK: - Configure CollectionView
extension IssueDetailViewController: UICollectionViewDelegate {    
    private func configureCollectionView() {
        collectionView?.delegate = self
        collectionView?.dataSource = dataSource
        collectionView?.allowsMultipleSelectionDuringEditing = true
    }
    
    private func registerCell() {
        let nibName = UINib(nibName: ViewID.cell, bundle: nil)
        collectionView?.register(nibName, forCellWithReuseIdentifier: ViewID.cell)
    }
    
    private func configureFlowLayout() {
        guard let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.sectionHeadersPinToVisibleBounds = true
        layout.itemSize.width = view.frame.width
    }
}

// MARK: - UICollectionViewDiffableDataSource
extension IssueDetailViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, CommentCellViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, CommentCellViewModel>
    
    private func makeDataSource() -> DataSource {
        guard let collectionView = collectionView else { return DataSource() }
        return DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, viewModel) -> IssueCommentCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewID.cell, for: indexPath)
            guard let listCell = cell as? IssueCommentCell else { return IssueCommentCell() }
            listCell.configureCell(viewModel: viewModel)
            //            let newSize = commentCell.commentLabel.sizeThatFits(CGSize(width: commentCell.commentLabel.frame.width, height: CGFloat.greatestFiniteMagnitude))
            //
            //            cell.heightAnchor.constraint(equalToConstant: newSize.height + 76).isActive = true
            //            cell.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
            
            return listCell
        })
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        guard let viewModel = viewModel else { return }
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.commentCellViewModels, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

// MARK: - IssueBottomSheetViewController
extension IssueDetailViewController {
    func configureBottomSheetView() {
        addChild(bottomSheetViewController)
        view.addSubview(bottomSheetViewController.view)
        bottomSheetViewController.didMove(toParent: self)
        let height = view.frame.height
        let width  = view.frame.width
        let maxY = view.frame.maxY
        bottomSheetViewController.view.frame = CGRect(x: 0, y: maxY, width: width, height: height)
    }
}
