//
//  FeedTableViewController.swift
//  MoudaTableView
//
//  Created by cauadc on 2018. 2. 1..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

private let cellId = "myFeedCellId"
class FeedTableVC: UITableViewController {
    
    var feeds: [Feed] = []
    var receivedFeed: Feed?
    
    let formatdate: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy년 MM월 dd일"
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar Item
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Logo"))
        imageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        tableView.register(MyFeedCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorColor = UIColor.clear
        tableView.scrollsToTop = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        feeds = dataCenter.feeds
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MyFeedCell else { return UITableViewCell() }
        
        let feed = feeds[indexPath.row]
        
        cell.feedView.titleLabel.text = feed.book.title
        cell.feedView.dateLabel.text = "\(formatdate.string(from: feed.date))"
        cell.feedView.lineLabel.text = feed.line
        cell.feedView.pageLabel.text = "Page \(feed.page)"
        cell.feedView.thoughtLabel.text = feed.thought
        
        return cell
    }
    
    // MARK: - Navigation

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedRow = indexPath.row
//
//        let feedDetailVC = FeedDetailVC()
//        feedDetailVC.feed = feeds[selectedRow]
//        feedDetailVC.indexPath = selectedRow
//
//        navigationController?.pushViewController(feedDetailVC, animated: true)
//    }
}
