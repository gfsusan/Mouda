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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func switchStatus(_ sender: Any) {
        if alarmSwitch.isOn == true {
            switchOn()
        }
    }
    
    func switchOn() {
        print("Switch On")
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
