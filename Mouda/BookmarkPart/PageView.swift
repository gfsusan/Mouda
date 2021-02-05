//
//  PageView.swift
//  Mouda
//
//  Created by Susan Kim on 2021/02/06.
//  Copyright © 2021 cauadc. All rights reserved.
//

import UIKit

class PageView: UIView {
    
    let pageTextField: UITextField = {
        let tv = UITextField()
        tv.font = .mySystemFont(ofSize: 17)
        tv.placeholder = "123"
        tv.contentHorizontalAlignment = .center
        
        let l = UILabel(text: "Page", font: .mySystemFont(ofSize: 17), textAlignment: .left, numberOfLines: 1)
        l.sizeToFit()
        l.frame = CGRect(x: 0, y: 0, width: l.frame.width + 8, height: l.frame.height)
        tv.leftViewMode = .always
        tv.leftView = l
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        hstack(UIView(),
               pageTextField,
               UIView(),
               distribution: .equalCentering
        ).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8)).withHeight(44)
        
        pageTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
        backgroundColor = .groupTableViewBackground

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
