//
//  LoginViewController.swift
//  moudaTab2
//
//  Created by CAUCSE on 2018. 6. 11..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func loginButtonPressed(_ sender: Any) {
        FirebaseDataService.instance.signIn(withEmail: "gfsusan@naver.com", password: "123456") {
            self.dismiss(animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
