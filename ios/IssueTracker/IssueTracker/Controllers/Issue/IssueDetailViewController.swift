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
    }
}

extension IssueDetailViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, CommentViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, CommentViewModel>
    
    private func makeDataSource() -> DataSource {
        guard let collectionView = collectionView else { return DataSource() }
        return DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, commentViewModel) -> CommentCollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "commentCell", for: indexPath)
            guard let commentCell = cell as? CommentCollectionViewCell else { return CommentCollectionViewCell() }
            self.binding(cell: commentCell, viewModel: commentViewModel)
            commentCell.layoutIfNeeded()
            
            let newSize = commentCell.commentLabel.sizeThatFits(CGSize(width: commentCell.commentLabel.frame.width, height: CGFloat.greatestFiniteMagnitude))
            
            cell.heightAnchor.constraint(equalToConstant: newSize.height + 76).isActive = true
            cell.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true

            return commentCell
        })
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(commentListViewModel.items, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func binding(cell: CommentCollectionViewCell, viewModel: CommentViewModel) {
        cell.userNameLabel.text = viewModel.user?.userID
        cell.commentDateLabel.text = viewModel.configureDate()
//        cell.userImageView = viewModel.user?.profileURL //ImageDownload 기능 필요
        cell.commentLabel.text = viewModel.content
        
    }
    
}

extension IssueDetailViewController: SnapshotApplicable {
    func downloadViewModel(issueID: Int) {
        self.commentListViewModel.delegate = self
        self.commentListViewModel.download(issueID: issueID)

    }
}
