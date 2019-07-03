//
//  TabBarController.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 23..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    private var addFeedTabBarItem: UIButton = {
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
        self.view.addSubview(addFeedTabBarItem)
        
        let tabBarItemsCount: CGFloat = 3
        let itemWidth = self.view.frame.size.width / tabBarItemsCount

        addFeedTabBarItem.widthAnchor.constraint(equalToConstant: itemWidth).isActive = true
        addFeedTabBarItem.topAnchor.constraint(equalTo: self.tabBar.topAnchor).isActive = true
        addFeedTabBarItem.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        addFeedTabBarItem.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    // clicked upload button (go to upload)
    @objc func handleAdd(sender : UIButton) {
        let addVC = AddFeedVC()
        let navContr = UINavigationController(navigationBarClass: MoudaNavigationBar.self, toolbarClass: nil)
        navContr.addChild(addVC)
        self.present(navContr, animated: true, completion: nil)
    }

}
