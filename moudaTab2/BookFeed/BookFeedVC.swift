//
//  BookFeedVC.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 10..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class BookFeedVC: UITableViewController {
    
    var bookmark:Bookmark?
    var feeds:[Feed] = []
    var dateFormatter:DateFormatter = DateFormatter()
    
    @IBOutlet weak var bookInfoView: UIView!
    
    @IBOutlet var tableTableView: UITableView!
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookmarkLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        print("view did load")
        
        bookInfoView.layer.shadowOpacity = 1
        bookInfoView.layer.shadowOffset = CGSize.zero
        bookInfoView.layer.shadowRadius = 3
        bookInfoView.layer.shadowPath = UIBezierPath(rect: bookInfoView.bounds).cgPath
        
        tableTableView.estimatedRowHeight = 250
        tableTableView.rowHeight = UITableViewAutomaticDimension
        
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feeds.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
