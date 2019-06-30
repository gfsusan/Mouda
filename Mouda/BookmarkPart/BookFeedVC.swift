//
//  BookFeedVC.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 10..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

private let bookFeedCellId = "bookFeedCellId"

class BookFeedVC: UITableViewController {
    var bookmark: Bookmark? {
        didSet {

            guard let bookmark = bookmark else { return }
            let book = bookmark.book
            if let imageUrl = book.coverImageURL {
                coverImageView.loadImageUsingUrlString(imageUrl: imageUrl)
            }
            titleLabel.text = book.title
            publisherLabel.text = book.publisher
            authorLabel.text = book.writer
            if let page = bookmark.pageMark {
                bookmarkLabel.text = "\(page)페이지까지 읽음"
            } else {
                bookmarkLabel.text = "다 읽음"
            }
            
            feeds += dataCenter.feeds(of: book)
        }
    }
    var indexPath: Int?
    var feeds: [Feed] = []
    
    var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy년 MM월 dd일"
        return df
    }()
    
    let coverImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20)
        return l
    }()
    
    let publisherLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        return l
    }()
    
    let authorLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        return l
    }()
    
    let bookmarkLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 17)
        l.textAlignment = .right
        return l
    }()
    
    lazy var deleteButton: UIBarButtonItem = {
        let bi = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(deletePressed))
        return bi
    }()
    
    @objc func deletePressed() {
       
        let alertView = UIAlertController(title: "삭제", message: "정말로 북마크를 삭제하시겠습니까?", preferredStyle: .alert)
        let delete = UIAlertAction(title: "삭제", style: .destructive) { (action) in
            if let book = self.bookmark?.book {
                if let index = self.indexPath {
                    dataCenter.delete(bookmarkOf: book, at: index, sender: self)
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .default) {(action) in
        }
        alertView.addAction(cancel)
        alertView.addAction(delete)
        present(alertView, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(BookFeedCell.self, forCellReuseIdentifier: bookFeedCellId)
        
        configureConstraints()
    }
    
    func configureConstraints() {
        navigationItem.rightBarButtonItem = deleteButton
        
        let bookInfoView = UIView()
        bookInfoView.frame = CGRect(x: 0, y: 0, width: 0, height: 156)

        bookInfoView.hstack(coverImageView,
                            view.stack(titleLabel,
                                       publisherLabel,
                                       authorLabel,
                                       bookmarkLabel,
                                       distribution: .fillEqually),
                            spacing: 8
        ).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
        
        tableView.tableHeaderView = bookInfoView

        coverImageView.widthAnchor.constraint(equalTo: coverImageView.heightAnchor, multiplier: 0.75).isActive = true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: bookFeedCellId, for: indexPath) as? BookFeedCell else { return UITableViewCell() }

        let feed = feeds[indexPath.row]
        
        cell.feedViewModel = FeedViewModel(feed: feed)
        
        return cell
        
    }
    

}
