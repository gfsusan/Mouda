//
//  PWDataStructure.swift
//  Mouda
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
    var login:LoginSet
    
    var setPath:String { get{
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return documentDirectory + setName
        }}
    
    init () {
        login = LoginSet.init()
        
        if FileManager.default.fileExists(atPath: self.setPath) {
            print(NSKeyedUnarchiver.unarchiveObject(withFile: self.setPath) as Any)
            if let setting = NSKeyedUnarchiver.unarchiveObject(withFile: self.setPath) as? LoginSet {
                login = setting
            }
        }
    }
    func defaultData() {
        KeychainController.saveToken(serviceIdentifier: "PW", userAccount: "login", token: "0000")
    }
    
    func save() {
        NSKeyedArchiver.archiveRootObject(self.login, toFile: self.setPath)
    }
}

class LoginSet:NSObject, NSCoding {
    var state:Bool
    
    override init() {
            state = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.state = aDecoder.decodeBool(forKey: "state")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.state, forKey: "state")
    }
}
