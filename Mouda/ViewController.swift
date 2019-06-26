//
//  ViewController.swift
//  Mouda
//
//  Created by Susan on 25/06/2019.
//  Copyright © 2019 cauadc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureConstraints()
        addTargets()
    }
    
    func configureConstraints() {
        
    }
    
    func addTargets() {
        
    }
}

extension UIViewController {
    func showAlert (title: String, message: String) {
        let alert = UIAlertController(title: title, message:message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
