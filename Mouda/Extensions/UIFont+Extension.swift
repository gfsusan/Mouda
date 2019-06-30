//
//  UIFont+Extensino.swift
//  Mouda
//
//  Created by Susan on 26/06/2019.
//  Copyright © 2019 cauadc. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "NanumMyeongjoOTF", size: size) ?? .systemFont(ofSize: size)
    }
    
    @objc class func myExtraBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "NanumMyeongjoOTFExtraBold", size: size) ?? .systemFont(ofSize: size)
    }
}
