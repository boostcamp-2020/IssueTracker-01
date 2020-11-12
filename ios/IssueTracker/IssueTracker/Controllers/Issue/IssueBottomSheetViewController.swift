//
//  IssueBottomSheetViewController.swift
//  IssueTracker
//
//  Created by 김석호 on 2020/11/09.
//

import UIKit

class IssueBottomSheetViewController: UIViewController {
    var viewModel: IssueBottomSheetViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.6) {
            self.moveView(state: .partial)
        }
    }
    
    @IBAction func clickCloseIssueButton(_ sender: Any) {
        viewModel?.closeIssue()
    }
}

// MARK: - Configure View
extension IssueBottomSheetViewController {
    private func configureView() {
        view.cornerRadius = 10
        view.clipsToBounds = true
    }
}

// MARK: - Configure Gesture
extension IssueBottomSheetViewController {
    private enum State {
        case partial
        case full
    }
    
    private enum Constant {
        static let fullViewYPosition: CGFloat = 100
        static var partialViewYPosition: CGFloat { UIScreen.main.bounds.height - 100 }
    }
    
    private func configureGesture() {
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(IssueBottomSheetViewController.panGesture))
        view.addGestureRecognizer(gesture)
    }
    
    private func moveView(state: State) {
        let yPosition = state == .partial ? Constant.partialViewYPosition : Constant.fullViewYPosition
        view.frame = CGRect(x: 0, y: yPosition, width: view.frame.width, height: view.frame.height)
    }
    
    private func moveView(panGestureRecognizer recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let minY = view.frame.minY

        if (minY + translation.y >= Constant.fullViewYPosition) && (minY + translation.y <= Constant.partialViewYPosition) {
            view.frame = CGRect(x: 0, y: minY + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: view)
        }
    }
    
    @objc private func panGesture(_ recognizer: UIPanGestureRecognizer) {
        moveView(panGestureRecognizer: recognizer)
        
        if recognizer.state == .ended {
            UIView.animate(withDuration: 1, delay: 0, options: [.allowUserInteraction]) {
                let state: State = recognizer.velocity(in: self.view).y >= 0 ? .partial:.full
                self.moveView(state: state)
            }
        }
    }
}
