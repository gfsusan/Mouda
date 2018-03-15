//
//  PWDataStructure.swift
//  moudaTab2
//
//  Created by CAUCSE on 2018. 3. 15..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import Foundation

let PWDatas:PWData = PWData()

let fileName = "/PWData.txt"
let setName = "/SetData.txt"

let LoginCheck = UserDefaults.standard


class PWData {
    func defaultData() {
        KeychainController.saveToken(serviceIdentifier: "PW", userAccount: "login", token: "0000")
    }
}
