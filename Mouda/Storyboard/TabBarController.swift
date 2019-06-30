//
//  TabBarController.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 23..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    private var addFeedTapBarItem: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "Empty.png"), for: .normal)
        button.addTarget(self, action: #selector(TabBarController.handleAdd(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddPostButton()
    }

    func setupAddPostButton() {
        self.view.addSubview(addFeedTapBarItem)
        
        let tabBarItemsCount: CGFloat = 3
        let itemWidth = self.view.frame.size.width / tabBarItemsCount

        addFeedTapBarItem.widthAnchor.constraint(equalToConstant: itemWidth).isActive = true
        addFeedTapBarItem.topAnchor.constraint(equalTo: self.tabBar.topAnchor).isActive = true
        addFeedTapBarItem.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        addFeedTapBarItem.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    // clicked upload button (go to upload)
    @objc func handleAdd(sender : UIButton) {
        let addVC = AddFeedVC()
        let navContr = UINavigationController(rootViewController: addVC)
        self.present(navContr, animated: true, completion: nil)
    }

}
