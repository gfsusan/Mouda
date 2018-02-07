//
//  FeedDetailViewController.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 7..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class FeedDetailVC: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var thoughtLabel: UILabel!
    
    var feed:Feed?
    let formatDate = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        formatDate.dateFormat = "yyyy년 MM월 dd일"
        // Do any additional setup after loading the view.
        
        // attribute text style
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        style.alignment = .center
        let attributes = [NSAttributedStringKey.paragraphStyle: style]
        
        if let myFeed = feed {
            titleLabel.text = myFeed.book.title
            dateLabel.text = "\(formatDate.string(from: myFeed.date))"
            lineLabel.attributedText = NSAttributedString(string: myFeed.line, attributes: attributes)
            pageLabel.text = "Page \(myFeed.page)"
            thoughtLabel.attributedText = NSAttributedString(string: myFeed.thought, attributes: attributes)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
