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
    
    @IBAction func appLock(_ sender: UISwitch) {
        if appLockSwitch.isOn == true {
            LoginCheck.set(1, forKey: "LoginAvailable")
            pin(.create)
            PWDatas.login.state = true
        } else if appLockSwitch.isOn == false {
            LoginCheck.set(0, forKey: "LoginAvailable")
            pin(.deactive)
            PWDatas.login.state = false
        }
        PWDatas.save()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        appLockSwitch.isOn = PWDatas.login.state
        
    }
    
    @IBAction func appLockStatus(_ sender: Any) {
    }
    
    @IBAction func touchIDStatus(_ sender: Any) {
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
