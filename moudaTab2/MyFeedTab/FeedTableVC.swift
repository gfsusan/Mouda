//
//  FeedTableViewController.swift
//  MoudaTableView
//
//  Created by cauadc on 2018. 2. 1..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class FeedTableVC: UITableViewController {

    var person1 = Person(name:"Sujin")
    var person2 = Person(name:"Taewook")
    var person3 = Person(name:"Yejoo")
    
    var book1 = Book(title:"적을 만들지 않는 대화법")
    var book2 = Book(title:"필요한 사람인가")
    var book3 = Book(title:"신경 끄기의 기술")
    var feeds:[Feed] = []
    
    let formatdate = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation Bar Item
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Logo"))
        imageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        
        self.tableView.separatorColor = UIColor.clear
        let feed1 = Feed(person: person1, book: book1, page: 110, line: "이기심은 자기 삶을 원하는대로 사는 것이 아니다. 남들에게 자기가 원하는대로 살아달라고 요구하는 것이다.", time: Date())
        let feed2 = Feed(person: person2, book: book2, page: 128, line: "남들에게 '고마운 존재'이기보다 '필요한 존재'가 되어라. 상대가 당신에게 고마워하기보다는 기대하고 의지하게 만들어라.", time: Date())
        let feed3 = Feed(person: person3, book: book3, page: 96, line: "기대는 오랫동안 기억되지만 감사의 마음은 금방 사라지기 때문이다.", time: Date())
        
        feeds.append(feed1)
        feeds.append(feed2)
        feeds.append(feed3)
        
        formatdate.dateFormat = "yyyy년 MM월 dd일"
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
        
        retCell.titleLabel.text = "\(feed.book.title)"
        retCell.lineLabel.text = feed.line
        retCell.dateLabel.text = "\(formatdate.string(from: feed.time))"
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
   
        }
    }
    */
}
