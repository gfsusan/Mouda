//
//  AppLockTableVC.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 9..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class AppLockTableVC: UITableViewController {

    
    @IBOutlet weak var appLockSwitch: UISwitch!
    @IBOutlet weak var touchIDSwitch: UISwitch!
    @IBOutlet weak var touchIDLabel: UILabel!
    @IBOutlet weak var changePasswordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appLockSwitch.isOn = PWDatas.login.state

    }
    
    @IBAction func appLockStatus(_ sender: Any) {
        if (appLockSwitch.isOn == true) {
            LoginCheck.set(1, forKey: "LoginAvailable")
            PWDatas.login.state = true
        } else if (appLockSwitch.isOn == false) {
            LoginCheck.set(0, forKey: "LoginAvailable")
            PWDatas.login.state = false
        }
        PWDatas.save()
    }
    
    @IBAction func touchIDStatus(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
