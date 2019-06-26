//
//  TabBarVC.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 23..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    private var addPostTapBarItem: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "Empty.png"), for: .normal)
        button.addTarget(self, action: #selector(TabBarVC.upload(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAddPostButton()
    }

    func setupAddPostButton() {
        self.view.addSubview(addPostTapBarItem)
        
        let tabBarItemsCount: CGFloat = 3
        let itemWidth = self.view.frame.size.width / tabBarItemsCount

        addPostTapBarItem.widthAnchor.constraint(equalToConstant: itemWidth).isActive = true
        addPostTapBarItem.topAnchor.constraint(equalTo: self.tabBar.topAnchor).isActive = true
        addPostTapBarItem.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        addPostTapBarItem.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // clicked upload button (go to upload)
    @objc func upload(sender : UIButton) {
        let addVC = AddPopUpVC()
        let navContr = UINavigationController(rootViewController: addVC)
        self.present(navContr, animated: true, completion: nil)
    }

}
