//
//  AddPopUpV.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 8..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class AddVC: UIViewController {
    
    var closeFlag = false
    
    @IBOutlet weak var popupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("뷰윌어피어잘됨")
        print(closeFlag)
        
    
        if closeFlag == false {
            popupButton.sendActions(for: .touchUpInside)
        } else {
            //change tab bar
            closeFlag = false
            if (self.presentingViewController as? UITabBarController) != nil {
                tabBarController?.selectedIndex = 0
            }

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        print("build")
        if let addPopup = segue.destination as? AddPopUpVC {
            print("segue")
            addPopup.addDelegate = self
        }
    }
 

}
