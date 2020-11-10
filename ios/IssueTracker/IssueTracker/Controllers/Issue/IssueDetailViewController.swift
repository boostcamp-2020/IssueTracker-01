//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/03.
//

import UIKit

class IssueDetailViewController: UIViewController {
    private lazy var dataSource = makeDataSource()
    
    @IBOutlet weak var collectionView: UICollectionView?
    
    var viewModel: CommentViewModel? {
        didSet {
            viewModel?.downloadData()
        }
    }
}

// MARK: - UICollectionViewDiffableDataSource
extension IssueDetailViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, CommentCellViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, CommentCellViewModel>
    
    private func makeDataSource() -> DataSource {
        guard let collectionView = collectionView else { return DataSource() }
        return DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, commentViewModel) -> IssueCommentCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "commentCell", for: indexPath)
            guard let commentCell = cell as? IssueCommentCell else { return IssueCommentCell() }
            self.binding(cell: commentCell, viewModel: commentViewModel)
            commentCell.layoutIfNeeded()
            
            let newSize = commentCell.commentLabel.sizeThatFits(CGSize(width: commentCell.commentLabel.frame.width, height: CGFloat.greatestFiniteMagnitude))
            
            cell.heightAnchor.constraint(equalToConstant: newSize.height + 76).isActive = true
            cell.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
            
            return commentCell
        })
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        guard let viewModel = viewModel else { return }
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.commentCellViewModels, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func binding(cell: IssueCommentCell, viewModel: CommentCellViewModel) {
        cell?.userNameLabel.text = viewModel.user?.userID
        cell?.commentDateLabel.text = viewModel.configureDate()
        //        cell.userImageView = viewModel.user?.profileURL //ImageDownload 기능 필요
        cell?.commentLabel.text = viewModel.content
    }
}
