//
//  FeedDetailViewController.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 7..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class FeedDetailVC: ViewController {
    
    var feed: Feed? {
        didSet {
            if let feed = feed {
                feedView.feedViewModel = FeedViewModel(feed: feed)
            }
        }
    }
    
    var indexPath: Int?
    
    var feedView: FeedView = {
        let v = FeedView()
        v.isSummaryMode = false
        return v
    }()
    
    lazy var modifyButton: UIBarButtonItem = {
        let bi = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(handleEdit(_:)))
        return bi
    }()
    
    lazy var deleteButton: UIBarButtonItem = {
        let bi = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(deletePressed(_:)))
        return bi
    }()
    
    @objc func deletePressed(_ sender: Any) {
        let alertView = UIAlertController(title: "삭제", message: "정말로 피드를 삭제하시겠습니까?", preferredStyle: .alert)
        let delete = UIAlertAction(title: "피드 삭제", style: .destructive) { (action) in
            if let index = self.indexPath {
                dataCenter.delete(feedAt: index)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .default) {(action) in
        }
        alertView.addAction(cancel)
        alertView.addAction(delete)
        present(alertView, animated: true, completion: nil)
    }
    
    @objc func handleEdit(_ sender: Any) {
        let modifyVC = ModifyFeedVC()
        modifyVC.originalFeed = feed
        modifyVC.indexPath = self.indexPath
        modifyVC.feedDetailDelegate = self
        let navContr = UINavigationController(rootViewController: modifyVC)
        self.present(navContr, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }

    override func configureConstraints() {
        navigationItem.rightBarButtonItems = [deleteButton, modifyButton]
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        
        let contentView = UIView()
        contentView.stack(feedView)
        
        scrollView.addSubview(contentView)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor)
        
        scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
