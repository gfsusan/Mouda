//
//  PWVC.swift
//  Mouda
//
//  Created by CAUCSE on 2018. 3. 15..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit
import LocalAuthentication

class PWVC: UIViewController {
    
    var count:Int = 0
    let Enter = UserDefaults.standard
    var key:String = ""
    var temp:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        count = 0
        key = KeychainController.loadToken(serviceIdentifier: "PW", userAccount: "login")! as String

        // Do any additional setup after loading the view.
    }
    
    func authenticateUser() {
        let authContext : LAContext = LAContext()
        var error: NSError?
        
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Biometric Check for application", reply: {successful, error -> Void in
                if successful {
                    print("TouchID Yes")
                }
                else {
                    print("TouchID No")
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonBack: UIButton!
    
    @IBOutlet weak var err: UILabel!
    @IBOutlet weak var enter1: UILabel!
    @IBOutlet weak var enter2: UILabel!
    @IBOutlet weak var enter3: UILabel!
    @IBOutlet weak var enter4: UILabel!
    
    @IBAction func press(_ sender: UIButton) {
        count += 1
        let digit = sender.currentTitle!
        temp.append(digit)
        print(temp)
        
        switch count {
        case 0:
            enter1.text = "__"
        case 1:
            enter1.text = "*"
        case 2:
            enter2.text = "*"
        case 3:
            enter3.text = "*"
        case 4:
            enter4.text = "*"
        default:
            break
        }
        
        if(count == 4) {
            if (key == temp) {
                count = 0
                self.dismiss(animated: true, completion: nil)
            } else {
                err.text = "다시 입력해주세요"
                temp = ""
                count = 0
                enter1.text = "__"
                enter2.text = "__"
                enter3.text = "__"
                enter4.text = "__"
            }
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        if(count > 0) {
            count -= 1
            temp.remove(at: temp.index(temp.endIndex, offsetBy: -1))
            switch count {
            case 0:
                enter1.text = "__"
            case 1:
                enter2.text = "__"
            case 2:
                enter3.text = "__"
            case 3:
                enter4.text = "__"
            default:
                break
            }
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
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
