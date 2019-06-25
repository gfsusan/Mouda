//
//  SettingTableVC.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 9..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit
import Foundation
import MessageUI
import UserNotifications

class SettingTableVC: UITableViewController, MFMailComposeViewControllerDelegate {
        
    @IBOutlet weak var myFeedCell: UITableViewCell!
    @IBOutlet weak var bookmarkCell: UITableViewCell!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var myFeedCount: UILabel!
    @IBOutlet weak var myBookmarkCount: UILabel!
    @IBOutlet weak var alarmTimeSmallLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myFeedCell.detailTextLabel?.text = "\(dataCenter.feeds.count)개"
        bookmarkCell.detailTextLabel?.text = "\(dataCenter.bookmarks.count)개"
    }

    @IBAction func feedbackEmail(_ sender: Any) {
        
        //피드백 이메일
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["gfsusan@naver.com"])
            mail.setMessageBody("<p>개발자님 멋있다!</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            print("Fail to send E-mail")
            // 경고창
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

