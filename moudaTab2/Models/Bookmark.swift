//
//  Bookmark.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 8..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import Foundation
import os.log

class Bookmark:NSObject, NSCoding {
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("bookmarks")
    
    var book:Book
    var pageMark:Int?
    
    init(book:Book, page:Int) {
        self.book = book
        self.pageMark = page
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let book = aDecoder.decodeObject(forKey: "book") as? Book else {
            os_log("Unable to decode the Book object for a Bookmark Object", log: OSLog.default, type: .debug)
            return nil
        }
        if let page = aDecoder.decodeObject(forKey: "pageMark") as? Int  {
            self.pageMark = page
        }
        self.book = book
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.book, forKey: "book")
        if let pageNum = self.pageMark {
            aCoder.encode(self.pageMark, forKey: "pageMark")
        }
    }
}
