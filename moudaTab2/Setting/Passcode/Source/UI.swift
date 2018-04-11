//
//  UI.swift
//  moudaTab2
//
//  Created by MBP04 on 2018. 4. 9..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

extension UIView {
    func rounded() {
        layer.cornerRadius = frame.width/2
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 77.0/255.0, green: 64.0/255.0, blue: 55.0/255.0, alpha: 1.0).cgColor
    }
    
    func shake(delegate: CAAnimationDelegate) {
        let animationKeyPath = "transform.translation.x"
        let shakeAnimation = "shake"
        let duration = 0.6
        let animation = CAKeyframeAnimation(keyPath: animationKeyPath)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = duration
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0]
        animation.delegate = delegate
        layer.add(animation, forKey: shakeAnimation)
    }
}

class Indicator: UIView {
    
    var isNeedClear = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rounded()
    }
}

class ImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        rounded()
    }
}

class Button: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        rounded()
    }
}
