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

    var alarmDelegate:AlarmVC?
    
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var myFeedCount: UILabel!
    @IBOutlet weak var myBookmarkCount: UILabel!
    @IBOutlet weak var alarmTimeSmallLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let alarmTime = self.alarmDelegate {
            print("alarmTime")
            alarmTimeSmallLabel.text = alarmTime.alarmTimeLabel.text
        }
        
    }
    
    @IBAction func switchStatus(_ sender: Any) {
//        if alarmSwitch.isOn == true {
//            if let alarmVC = self.alarmDelegate {
//                print("SwitchOn")
//                alarmVC.switchOn()
//            }
//        }
    }
    

    @IBAction func feedbackEmail(_ sender: Any) {
        
        //피드백 이메일
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["gfsusan@naver.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            print("Fail to send E-mail")
            // 경고창
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

