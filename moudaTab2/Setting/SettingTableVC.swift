//
//  SettingTableVC.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 9..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit
import Foundation
import MessageUI
import UserNotifications

class SettingTableVC: UITableViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var myFeedCount: UILabel!
    @IBOutlet weak var myBookmarkCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func switchStatus(_ sender: Any) {
        if alarmSwitch.isOn == true {
            switchOn()
        }
    }
    
    func switchOn() {
        print("Switch On")
    }

    @IBAction func feedbackEmail(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["gfsusan@naver.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            print("Fail to send E-mail")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
