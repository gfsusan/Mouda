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
    @IBOutlet weak var changePasswordLabel: UILabel!
    @IBOutlet weak var changePasswordButton: UIButton!
    
    @IBAction func appLock(_ sender: UISwitch) {
        if (appLockSwitch.isOn == true) {
            LoginCheck.set(1, forKey: "LoginAvailable")
            pin(.create)
            changePasswordLabel.isEnabled = true
            changePasswordButton.isEnabled = true
            PWDatas.login.state = true
        } else if (appLockSwitch.isOn == false) {
            LoginCheck.set(0, forKey: "LoginAvailable")
            changePasswordLabel.isEnabled = false
            changePasswordButton.isEnabled = false
            PWDatas.login.state = false
        }
        PWDatas.save()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        appLockSwitch.isOn = PWDatas.login.state
        if (appLockSwitch.isOn == true) {
            changePasswordLabel.isEnabled = true
            changePasswordButton.isEnabled = true
        } else if (appLockSwitch.isOn == false) {
            changePasswordLabel.isEnabled = false
            changePasswordButton.isEnabled = false
        }
        
    }
    
    @IBAction func changePassword(_ sender: UIButton) {
        pin(.change)
    }
    
    func pin(_ mode: ALMode) {
        
        var appearance = ALAppearance()
        appearance.title = "비밀번호를 입력해주세요."
        appearance.isSensorsEnabled = true
        
        AppLocker.present(with: mode, and: appearance)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
