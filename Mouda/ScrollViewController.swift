//
//  ScrollViewController.swift
//  Mouda
//
//  Created by Susan Kim on 2021/02/07.
//  Copyright © 2021 cauadc. All rights reserved.
//

import UIKit

class ScrollViewController: ViewController {
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureConstraints() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        
        scrollView.addSubview(contentView)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor)
        
        scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
