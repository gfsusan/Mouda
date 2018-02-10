//
//  Feed.swift
//  초안
//
//  Created by cauadc on 2018. 1. 30..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import Foundation
import UIKit


class Feed: NSObject, NSCoding {

    let book:Book
    var line:String
    var thought:String
    var page:Int
    let date:Date

    init(book:Book, page:Int, line:String, thought:String) {
        self.book = book
        self.line = line
        self.thought = thought
        self.page = page
        self.date = Date()
    }
    
    init(book:Book, page:Int, line:String, thought:String, date:Date) {
        self.book = book
        self.line = line
        self.thought = thought
        self.page = page
        self.date = date
    }
    
//    override init() {
//        book = Book()
//        line = "DefaultLine"
//        thought = "DefaultThought"
//        page = 1
//        date = Date()
//    }
//
    required init?(coder aDecoder: NSCoder) {
        self.book = aDecoder.decodeObject(forKey: "book") as! Book
        self.line = aDecoder.decodeObject(forKey: "line") as! String
        self.thought = aDecoder.decodeObject(forKey: "thought") as! String
        self.page = aDecoder.decodeInteger(forKey: "page")
        let timeIntervalSince1970 = aDecoder.decodeDouble(forKey: "date")
        self.date = Date(timeIntervalSince1970: timeIntervalSince1970)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.book, forKey: "book")
        aCoder.encode(self.line, forKey: "line")
        aCoder.encode(self.thought, forKey: "thought")
        aCoder.encode(self.page, forKey: "page")
        aCoder.encode(self.date.timeIntervalSince1970, forKey: "date")
    }
}
