//
//  CountLabel.swift
//  Mouda
//
//  Created by Susan Kim on 2021/03/17.
//  Copyright © 2021 cauadc. All rights reserved.
//

import UIKit

class CountLabel: UILabel {
    
    var count: Int = 0 {
        
        didSet {
            updateView()
        }
    }
    
    var title: String = "냠냠" {
        didSet {
            updateView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textAlignment = .center
        self.numberOfLines = 2
    }
    
    func updateView() {
        self.text = "\(count) \n \(title)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
