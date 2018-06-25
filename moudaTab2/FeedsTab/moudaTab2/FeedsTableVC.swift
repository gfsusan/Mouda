//
//  FeedsTableVC.swift
//  moudaTab2
//
//  Created by CAUCSE on 2018. 6. 11..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit
import Firebase

class FeedsTableVC: UITableViewController {
    
    let formatdate = DateFormatter()
    var feeds:[Feed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatdate.dateFormat = "yyyy년 MM월 dd일"    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchFeeds()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feeds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myFeedCell", for: indexPath) as! MyFeedCell

        let feed = feeds[indexPath.row]
        cell.titleLabel.text = feed.book.title
        cell.lineLabel.text = feed.line
        cell.dateLabel.text = "\(formatdate.string(from: feed.date))"
//        cell.pageLabel.text = "\(feed.page)"
//        cell.thoughtLabel.text = feed.thought
        
        return cell
    }

    func fetchFeeds() {
        print("fetch feeds")
        FirebaseDataService.instance.feedRef.observe(.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.feeds.removeAll()
                
                for feeds in snapshot.children.allObjects as! [DataSnapshot] {
                    let feedObject = feeds.value as? [String: AnyObject]
                    let feedLine = feedObject?["line"]
                    let feedPage = feedObject?["page"]
                    let feedDate = feedObject?["date"]
                    let feedThought = feedObject?["thought"]
                    
                    let feedBookUid = feedObject?["bookUid"]
                    FirebaseDataService.instance.bookRef.child(feedBookUid as! String).observeSingleEvent(of: .value, with: {(snapshot) in
                            let bookObject = snapshot.children.nextObject() as! DataSnapshot
//                            let bookTitle = bookObject["title"]
//                            let bookPublisher = bookObject["publisher"]
//                            let bookAuthor = bookObject["author"]
//                            let bookCoverImageURL = bookObject["coverImageURL"]
                        
                        
                    })
                    print(feedDate)
                    print(Date(timeIntervalSince1970: feedDate as! TimeInterval))
                    
                    
                    let feed = Feed(book: Book(title: "dlsfj" as! String, coverImageURL: "dslfasdlk", publisher: "sdsdf", writer: "sdf", bookDescription: "dslkfj"), page: feedPage as! Int, line: feedLine as! String, thought: feedThought as! String, date: Date(timeIntervalSince1970: feedDate as! TimeInterval))
                    
                                        self.feeds.append(feed)
                }
                 self.tableView.reloadData()
            }
        })
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
