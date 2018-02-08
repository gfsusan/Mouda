//
//  Book.swift
//  초안
//
//  Created by cauadc on 2018. 1. 30..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import Foundation
import UIKit

class Book:NSObject, NSCoding {
    var title:String
    var coverImage:UIImage
    var publisher:String
    var writer:String
    var bookDescription:String
    
    override init () {
        title = "DefaultTitle"
        coverImage = #imageLiteral(resourceName: "tempBook1")
        publisher = "DefaultPublisher"
        writer = "DefaultWriter"
        bookDescription = "DefaultDescription"
    }
    
    init(title:String, coverImage:UIImage, publisher:String, writer:String, bookDescription:String) {
        self.title = title
        self.coverImage = coverImage
        self.publisher = publisher
        self.writer = writer
        self.bookDescription = bookDescription
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.coverImage = aDecoder.decodeObject(forKey: "coverImage") as! UIImage
        self.publisher = aDecoder.decodeObject(forKey: "publisher") as! String
        self.writer = aDecoder.decodeObject(forKey: "writer") as! String
        self.bookDescription = aDecoder.decodeObject(forKey: "bookDescription") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.coverImage, forKey: "coverImage")
        aCoder.encode(self.publisher, forKey: "publisher")
        aCoder.encode(self.writer, forKey: "writer")
        aCoder.encode(self.bookDescription, forKey: "bookDescription")
    }
}

