//
//  FeedTableViewController.swift
//  MoudaTableView
//
//  Created by cauadc on 2018. 2. 1..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class FeedTableVC: UITableViewController {
    
    var feeds:[Feed] = []
//    @IBOutlet weak var myFeedButton: UIButton!
    let formatdate = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feeds += dataCenter.feeds
        
        // refresh
        refreshData()
//        myFeedButton.addTarget(self, action: Selector(("refresh:")), for: .touchUpInside)
//        var refresher = UIRefreshControl()
//        refresher.addTarget(self, action: Selector(("refresh:")), for: .valueChanged)

        print("FeedTableVC")
        // Navigation Bar Item
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Logo"))
        imageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        
        self.tableView.separatorColor = UIColor.clear
    
        
        formatdate.dateFormat = "yyyy년 MM월 dd일"
    }
    
    func refreshData() {
        refreshControl?.beginRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        feeds = dataCenter.feeds
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "myFeedCell", for: indexPath) as? MyFeedCell
        
        guard let retCell = cell else {
            return cell!
        }
        
        var feed = feeds[indexPath.row]
        
        if let title = feed.book.title {
            retCell.titleLabel.text = title
        }
//        retCell.lineLabel.text = feed.line
        retCell.dateLabel.text = "\(formatdate.string(from: feed.date))"
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        style.alignment = .center
        let attributes = [NSAttributedStringKey.paragraphStyle: style]
        retCell.lineLabel.attributedText = NSAttributedString(string: feed.line, attributes: attributes)
        
        return retCell
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedRow = indexPath.row
            
            let vc = segue.destination as? FeedDetailVC
            vc?.feed = feeds[selectedRow]
            vc?.indexPath = selectedRow
        }
    }

}
