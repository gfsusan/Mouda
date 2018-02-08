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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Present Modally
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("뷰윌어피어잘됨")
        if closeFlag == false {
            let sb = UIStoryboard(name: "AddPopUp", bundle: nil)
            let popup = sb.instantiateInitialViewController()!
            self.present(popup, animated: true)
        } else {
            //첫번째 탭으로 넘어가는 코드
            closeFlag = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
