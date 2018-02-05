//
//  Feed.swift
//  초안
//
//  Created by cauadc on 2018. 1. 30..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import Foundation
import UIKit

class Feed {
    let person:Person
    let book:Book
//    var image:UIImage?
    var line:String
    var thought:String?
    var page:Int
    var lock:Bool?
    let time:Date
//
    init(person:Person, book:Book, page:Int, line:String, time:Date) {
        self.person = person
        self.book = book
//        self.image = image
        self.line = line
//        self.thought = thought
        self.page = page
//        self.lock = lock
        self.time = Date()
    }
    
//    func likeByOther(person:Person) {
//        // 좋아요 누른 [person]에 없으면 추가, 있으면 아무 것도 안함 .
//    }
//    
//    func toggleLock () {
//        self.lock = !self.lock
//        if lock == true {
//            print("locked")
//        } else {
//            print("unlocked")
//        }
//    }
}
