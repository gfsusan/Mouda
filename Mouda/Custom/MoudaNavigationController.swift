//
//  MoudaNavigationController.swift
//  Mouda
//
//  Created by Susan Kim on 2021/02/04.
//  Copyright © 2021 cauadc. All rights reserved.
//

import UIKit

class MoudaNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = .navBarColor
        navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        navigationBar.tintColor = .white
    }

}
