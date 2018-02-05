//
//  Person.swift
//  초안
//
//  Created by cauadc on 2018. 1. 30..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import Foundation
import UIKit

class Person {
    var name:String
    var introduction:String?
    var profileImage:UIImage?
//    var bookmark:[Bookmark]?
    var myFeeds:[Feed]?
    var likeFeeds:[Feed]?
    var following:[Person]?
    
    init(name:String) {
        self.name = name
    }
    
    
}
