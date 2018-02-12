//
//  BookFeedVC.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 10..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class BookFeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var bookmark:Bookmark?
    var indexPath:Int?
    var feeds:[Feed] = []
    var dateFormatter:DateFormatter = DateFormatter()
    
    @IBOutlet weak var bookInfoView: UIView!
    
    @IBOutlet var tableTableView: UITableView!
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookmarkLabel: UILabel!
    
    @IBAction func deletePressed(_ sender: Any) {
       
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
        print("view did load")
        tableTableView.delegate = self
        tableTableView.dataSource = self
        
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        bookInfoView.layer.shadowOpacity = 1
        bookInfoView.layer.shadowOffset = CGSize(width: 0, height: 5)
        bookInfoView.layer.shadowRadius = 5
        bookInfoView.layer.shadowPath = UIBezierPath(rect: bookInfoView.bounds).cgPath
        bookInfoView.layer.masksToBounds = false
        
        
        if let bm = bookmark {
            print(bm)
            feeds += dataCenter.feeds(of: bm.book)
             print(feeds)
        }
       
    }
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        
        coverImageView.image = bookmark?.book.coverImage
        titleLabel.text = bookmark?.book.title
        publisherLabel.text = bookmark?.book.publisher
        authorLabel.text = bookmark?.book.writer
        if let page = bookmark?.page {
             bookmarkLabel.text = "\(page)페이지까지 읽음"
        } else {
            bookmarkLabel.text = "다 읽음"
        }
       
    }
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feeds.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookFeedCell", for: indexPath) as! BookFeedCell

        // Configure the cell...
        let feed = feeds[indexPath.row]
        
//        cell?.textLabel?.text = feed.book.title
        cell.dateLabel.text = dateFormatter.string(from: feed.date)
        cell.lineLabel.text = feed.line
        cell.pageLabel.text = "Page \(feed.page)"
        cell.thoughtLabel.text = feed.thought
    
        return cell
        
    }
    

}
