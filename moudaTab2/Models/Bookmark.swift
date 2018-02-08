//
//  Bookmark.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 8..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import Foundation

class Bookmark:NSObject, NSCoding {
    var book:Book
    var page:Int
    
    init(book:Book, page:Int) {
        self.book = book
        self.page = page
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.book = aDecoder.decodeObject(forKey: "book") as! Book
        self.page = aDecoder.decodeInteger(forKey: "page")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.book, forKey: "book")
        aCoder.encode(self.page, forKey: "page")
    }
}
