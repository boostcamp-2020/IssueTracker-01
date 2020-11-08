//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/03.
//

import UIKit

class IssueDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var commentListViewModel = CommentListViewModel()
    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension IssueDetailViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Comment>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Comment>
    
    private func makeDataSource() -> DataSource {
        guard let collectionView = collectionView else { return DataSource() }
        return DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, comment) -> CommentCollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "commentCell", for: indexPath)
            guard let listCell = cell as? CommentCollectionViewCell else { return CommentCollectionViewCell() }
            self.binding(cell: listCell, comment: comment)
            return listCell
        })
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(commentListViewModel.items, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func binding(cell: CommentCollectionViewCell, comment: Comment) {
        cell.userNameLabel.text = comment.user?.userID
        cell.commentDateLabel.text = comment.createdAt
//        cell.userImageView = comment.user?.profileURL //ImageDownload 기능 필요
        cell.commentTextView.text = comment.content
    }
    
}

extension IssueDetailViewController: SnapshotApplicable {
    func downloadViewModel() {
        self.commentListViewModel.delegate = self
        self.commentListViewModel.download()

    }
}
