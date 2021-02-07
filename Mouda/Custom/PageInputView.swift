//
//  PageInputView.swift
//  Mouda
//
//  Created by Susan Kim on 2021/02/06.
//  Copyright © 2021 cauadc. All rights reserved.
//

import UIKit

class PageInputView: UIView {
    
    var page: Int? {
        get {
            guard let pageText = pageTextField.text else { return nil }
            return Int(pageText)
        }
    }
    
    let pageTextField: UITextField = {
        let tv = UITextField()
        tv.font = .mySystemFont(ofSize: 17)
        tv.placeholder = "123"
        tv.contentHorizontalAlignment = .center
        tv.keyboardType = .numberPad
        
        let l = UILabel(text: "Page ", font: .mySystemFont(ofSize: 17), textAlignment: .left, numberOfLines: 1)
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
