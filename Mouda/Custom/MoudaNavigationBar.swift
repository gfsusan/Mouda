//
//  MoudaNavigationBar.swift
//  Mouda
//
//  Created by Susan Kim on 04/07/2019.
//  Copyright © 2019 cauadc. All rights reserved.
//

import UIKit

class MoudaNavigationBar: UINavigationBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        barTintColor = .navBarColor
        titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        tintColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
