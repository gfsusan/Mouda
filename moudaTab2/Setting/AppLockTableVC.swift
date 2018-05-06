//
//  AppLockTableVC.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 9..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

struct Setting {
    enum State:String {
        case Passcode
        case ChangePasscodeLabel
        case ChangePasscodeBtn
    }
}

class AppLockTableVC: UITableViewController {
    
    @IBOutlet weak var appLockSwitch: UISwitch!
    @IBOutlet weak var changePasswordLabel: UILabel!
    @IBOutlet weak var changePasswordButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setState()
    }
    
    func setState() {
        let userDefaults = UserDefaults.standard
        
        if let passcode = userDefaults.value(forKey: Setting.State.Passcode.rawValue), let changePasscodeLabel = userDefaults.value(forKey: Setting.State.ChangePasscodeLabel.rawValue), let changePasscodeBtn = userDefaults.value(forKey: Setting.State.ChangePasscodeBtn.rawValue) {
            self.appLockSwitch.isOn = passcode as! Bool
            self.changePasswordLabel.isEnabled = changePasscodeLabel as! Bool
            self.changePasswordButton.isEnabled = changePasscodeBtn as! Bool
        } else {
            //Default Value
            appLockSwitch.isOn = false
            changePasswordLabel.isEnabled = false
            changePasswordButton.isEnabled = false
        }
    }
    
    @IBAction func changePassword(_ sender: UIButton) {
        pin(.change)
    }
    
    func pin(_ mode: ALMode) {
        
        var appearance = ALAppearance()
        appearance.title = "비밀번호"
        appearance.isSensorsEnabled = true
        
        AppLocker.present(with: mode, and: appearance)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AppLockTableVC {
    @IBAction func appLock(_ sender: UISwitch) {
        if appLockSwitch.isOn == true {
            pin(.create)
            changePasswordLabel.isEnabled = true
            changePasswordButton.isEnabled = true
        } else if appLockSwitch.isOn == false {
            changePasswordLabel.isEnabled = false
            changePasswordButton.isEnabled = false
        }
        UserDefaults.standard.set(appLockSwitch.isOn, forKey: Setting.State.Passcode.rawValue)
        UserDefaults.standard.set(changePasswordLabel.isEnabled, forKey: Setting.State.ChangePasscodeLabel.rawValue)
        UserDefaults.standard.set(changePasswordButton.isEnabled, forKey: Setting.State.ChangePasscodeBtn.rawValue)
    }
}
