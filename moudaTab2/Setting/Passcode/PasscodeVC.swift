//
//  PasscodeVC.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 3. 21..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit
import LocalAuthentication
import Security

public enum PasscodeType {
    case authenticate
    case askCode
    case changeCode
}

class PasscodeVC: UIViewController {
    
    var config: PasscodeConfig!
    var type = PasscodeType.authenticate
    
    var compareCode: String?
    var code = "" {
        didSet {
            var count = 0
            
            for view in self.passcode.arrangedSubviews {
                if let view = view as? PasscodeCharacter {
                    view.value = count < code.count
                    count += 1
                }
            }
            
            guard self.code.count == 4 else { return }
            
            switch type {
            case .authenticate, .askCode:
                if code == self.config.passcodeGetter() {
                    self.dismiss(animated: true)
                } else {
                    self.displayError()
                }
            case .changeCode:
                if compareCode == nil {
                    compareCode = code
                    self.resetCode()
                    UILabel.animate(withDuration: 0.3, animations: {self.Errcode.alpha = 1.0})
                    return
                } else {
                    if compareCode == code {
                        self.config.passcodeSetter(code)
                        self.dismiss(animated: true)
                    } else {
                        self.displayError()
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var passcode: UIStackView!
    @IBOutlet weak var Errcode: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBAction func dismissButton(_ sender: Any) {
    }
    
    
    var authenticatedCompletion: ((Bool) -> Void)?
    var dismissCompletion: (() -> Void)?

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        switch type {
        case .changeCode:
            self.Errcode.text = Localized("passcodeNew")
        case .askCode:
            self.Errcode.text = Localized("passcodeText")
        default:
            self.Errcode.text = Localized("passcodeText")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func resetCode() {
        self.code = ""
    }
    
    public func dismiss(success: Bool) {
        if let dismissCompletion = dismissCompletion {
            dismissCompletion()
            self.authenticatedCompletion?(success)
        } else {
            self.dismiss(animated: true) {
                self.authenticatedCompletion?(success)
            }
        }
    }
    
    func displayError() {
        self.view.isUserInteractionEnabled = false
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.15
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.passcode.center.x - 10, y: self.passcode.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.passcode.center.x + 10, y: self.passcode.center.y))
        
        self.passcode.layer.add(animation, forKey: "position")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + animation.duration * 2.5) {
            self.code = ""
            self.view.isUserInteractionEnabled = true
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressButton(_ sender: UIButton) {
        guard let button = sender as? NumberButton else {
            self.code = String(self.code.dropLast(1))
            return
        }
        code.append(button.value)
    }
    @IBAction func dismissBtn(_ sender: Any) {
        self.code = ""
        self.dismiss(success: false)
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
