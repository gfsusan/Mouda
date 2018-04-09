//
//  AppLocker.swift
//  moudaTab2
//
//  Created by MBP04 on 2018. 4. 9..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit
import LocalAuthentication

enum ALConstants {
    static let nibName = "AppLocker"
    static let kPincode = "pincode"
    static let kLocalizedReason = "Unlock with sensor"
    static let duration = 0.3
    static let maxPinLength = 4
    
    enum button: Int {
        case delete = 1000
        case cancel = 1001
    }
}

struct ALAppearance {
    var title: String?
    var subtitle: String?
    var color: UIColor?
    var isSensorsEnabled: Bool?
}

enum ALMode {
    case validate
    case change
    case deactive
    case create
}

class AppLocker: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var submessageLabel: UILabel!
    @IBOutlet var pinIndicator: [Indicator]!
    
    @IBOutlet weak var cancleButton: UIButton!
    
    fileprivate let context = LAContext()
    fileprivate var pin = ""
    fileprivate var reservedPin = ""
    fileprivate var isFirstCreationStep = true
    fileprivate var savedPin: String? {
        get {
            return UserDefaults.standard.string(forKey: ALConstants.kPincode)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: ALConstants.kPincode)
        }
    }
    
    fileprivate var mode: ALMode? {
        didSet {
            let mode = self.mode ?? .validate
            switch mode {
            case .create:
                submessageLabel.text = "비밀번호를 입력해 주세요."
            case .change:
                submessageLabel.text = "비밀번호를 입력해 주세요."
            case .deactive:
                submessageLabel.text = "비밀번호를 입력해 주세요."
            case .validate:
                submessageLabel.text = "비밀번호를 입력해 주세요."
                isFirstCreationStep = false
            }
        }
    }
    
    fileprivate func precreateSettings() {
        mode = .create
        clearView()
    }
    
    fileprivate func drawing(isNeedClear: Bool, tag: Int? = nil) {
        let results = pinIndicator.filter { $0.isNeedClear == isNeedClear }
        let pinView = isNeedClear ? results.last : results.first
        pinView?.isNeedClear = !isNeedClear
        
        UIView.animate(withDuration: ALConstants.duration, animations: {
            pinView?.backgroundColor = isNeedClear ? .clear : .white
        }) { _ in
            isNeedClear ? self.pin = String(self.pin.dropLast()) : self.pincodeChecker(tag ?? 0)
        }
        
    }
    fileprivate func pincodeChecker(_ pinNumber: Int) {
        if pin.count < ALConstants.maxPinLength {
            pin.append("\(pinNumber)")
            if pin.count == ALConstants.maxPinLength {
                switch mode ?? .validate {
                case .create:
                    createModeAction()
                case .change:
                    changeModeAction()
                case .deactive:
                    deactiveModeAction()
                case .validate:
                    validateModeAction()
                }
            }
        }
    }
    
    fileprivate func createModeAction() {
        if isFirstCreationStep {
            isFirstCreationStep = false
            reservedPin = pin
            clearView()
            submessageLabel.text = "비밀번호를 한 번 더 입력해주세요."
        } else {
            confirmPin()
        }
    }
    
    fileprivate func changeModeAction() {
        pin == savedPin ? precreateSettings() : incorrectPinAnimation()
    }
    
    fileprivate func deactiveModeAction() {
        pin == savedPin ? removePin() : incorrectPinAnimation()
    }
    
    fileprivate func validateModeAction() {
        pin == savedPin ? dismiss(animated: true, completion: nil) : incorrectPinAnimation()
    }
    
    fileprivate func removePin() {
        UserDefaults.standard.removeObject(forKey: ALConstants.kPincode)
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func confirmPin() {
        if pin == reservedPin {
            savedPin = pin
            dismiss(animated: true, completion: nil)
        } else {
            incorrectPinAnimation()
        }
    }
    
    fileprivate func incorrectPinAnimation() {
        pinIndicator.forEach { view in
            view.shake(delegate: self)
            view.backgroundColor = .clear
        }
    }
    
    fileprivate func clearView() {
        pin = ""
        pinIndicator.forEach { view in
            view.isNeedClear = false
            UIView.animate(withDuration: ALConstants.duration, animations: {
                view.backgroundColor = .clear
            })
        }
    }
    
    fileprivate func checkSensors() {
        guard mode == .validate else {return}
        
        var policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
        
        if #available(iOS 9.0, *) {
            policy = .deviceOwnerAuthentication
        }
        
        var err: NSError?
        
        guard context.canEvaluatePolicy(policy, error: &err) else {return}
        
        context.evaluatePolicy(policy, localizedReason: ALConstants.kLocalizedReason, reply: { success, error in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func keyboardPressed(_ sender: UIButton) {
        switch sender.tag {
        case ALConstants.button.delete.rawValue:
            drawing(isNeedClear: true)
        case ALConstants.button.cancel.rawValue:
            clearView()
            dismiss(animated: true, completion: nil)
        default:
            drawing(isNeedClear: false, tag: sender.tag)
        }
    }
    
}

extension AppLocker: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        clearView()
    }
}

extension AppLocker {
    class func present(with mode: ALMode, and config: ALAppearance? = nil) {
        guard let root = UIApplication.shared.keyWindow?.rootViewController,
            let locker = Bundle.main.loadNibNamed(ALConstants.nibName, owner: self, options: nil)?.first as? AppLocker else {
                return
        }
        locker.messageLabel.text = config?.title ?? ""
        locker.submessageLabel.text = config?.subtitle ?? ""
        locker.view.backgroundColor = config?.color ?? .black
        locker.mode = mode
        
        if config?.isSensorsEnabled ?? false {
            locker.checkSensors()
        }
        
        root.present(locker, animated: true, completion: nil)
    }
}
