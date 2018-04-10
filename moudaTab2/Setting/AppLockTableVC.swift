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
                
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func appLockStatus(_ sender: Any) {
    }
    
    @IBAction func touchIDStatus(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
