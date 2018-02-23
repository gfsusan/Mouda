//
//  TabBarVC.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 23..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // custom button
        let itemWidth = self.view.frame.size.width / 5
        let itemHeight = self.tabBar.frame.size.height
        let button = UIButton(frame: CGRect(x: itemWidth * 2, y: self.view.frame.size.height - itemHeight, width: itemWidth - 10, height: itemHeight))
        button.setBackgroundImage(UIImage(named: "AddTabBarIcon.png"), for: .normal)
        button.addTarget(self, action: #selector(TabBarVC.upload(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // clicked upload button (go to upload)
    @objc func upload(sender : UIButton) {
        let storyboard = UIStoryboard(name: "Add", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddVC") as UIViewController
        present(vc, animated: true, completion: nil)
    }

}
