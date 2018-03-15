//
//  Feed.swift
//  초안
//
//  Created by cauadc on 2018. 1. 30..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Feed: NSObject, NSCoding {

    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("feeds")
    
    //MARK: Properties
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
    
    required init?(coder aDecoder: NSCoder) {
        guard let book = aDecoder.decodeObject(forKey: "book") as? Book else {
            os_log("Unable to decode the Book object for a Feed object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let line = aDecoder.decodeObject(forKey: "line") as? String else {
            os_log("Unable to decode the line for a Feed object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let thought = aDecoder.decodeObject(forKey: "thought") as? String else {
            os_log("Unable to decode the line for a Feed object.", log: OSLog.default, type: .debug)
            return nil
        }
        let timeIntervalSince1970 = aDecoder.decodeDouble(forKey: "date")
        
        self.book = book
        self.line = line
        self.thought = thought
        self.page = aDecoder.decodeInteger(forKey: "page")
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


