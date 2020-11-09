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
        
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        
        downloadtest()
//        downloadViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func downloadtest() {
        let jsonString = """
        {
           "issueId": 1,
           "title": "test",
           "isOpen": 1,
           "createdAt": "2020-11-03T12:39:18.000Z",
           "User": {
               "userId": "sangw3433",
               "profile_url": "https://avatars2.githubusercontent.com/u/66261552?v=4"
           },
           "IssueLabels": [
               {
                   "id": 1,
                   "Label": {
                       "labelName": "frontend",
                       "color": "red"
                   }
               },
               {
                   "id": 2,
                   "Label": {
                       "labelName": "backend",
                       "color": "blue"
                   }
               }
           ],
           "MileStone": {
               "title": "week1",
               "Issues": [
                   {
                       "isOpen": 1
                   },
                   {
                       "isOpen": 1
                   }
               ]
           },
           "Comments": [
               {
                   "commentId": 1,
                   "content": "gooooood",
                   "createdAt": "2020-11-03T12:42:51.000Z",
                   "User": {
                       "userId": "sangw3433",
                       "profile_url": "https://avatars2.githubusercontent.com/u/66261552?v=4"
                   }
               },
               {
                   "commentId": 2,
                   "content": "test gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest gooooddatest goooodda",
                   "createdAt": "2020-11-03T12:44:06.000Z",
                   "User": {
                       "userId": "jsangwoo",
                       "profile_url": "https://avatars3.githubusercontent.com/u/56758228?v=4"
                   }
               }
           ]
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        let issue = try? JSONDecoder().decode(Issue.self, from: jsonData)
        self.commentListViewModel.items = issue?.comments.map { CommentViewModel(comment: $0) } ?? []
        self.applySnapshot()
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
    func downloadViewModel() {
        self.commentListViewModel.delegate = self
        self.commentListViewModel.download()

    }
}
