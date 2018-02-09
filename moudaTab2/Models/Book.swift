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
    var title: String?
    var coverImage: UIImage?
    var coverImageURL: String?
    var publisher: String?
    var writer: String?
    
    override init () {
        title = "DefaultTitle"
        coverImageURL = "DefaultImageURL"
        publisher = "DefaultPublisher"
        writer = "DefaultWriter"
    }
    
    init(title:String, coverImageURL:String, publisher:String, writer:String, bookDescription:String) {
        self.title = title
        self.coverImageURL = coverImageURL
        self.publisher = publisher
        self.writer = writer
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let title = aDecoder.decodeObject(forKey: "title") as? String {
            self.title = title
        }
        if let coverImageURL = aDecoder.decodeObject(forKey: "coverImage") as? String {
            self.coverImageURL = coverImageURL
        }
        if let publisher = aDecoder.decodeObject(forKey: "publisher") as? String {
             self.publisher = publisher
        }
        if let writer = aDecoder.decodeObject(forKey: "writer") as? String {
            self.writer = writer
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.coverImageURL, forKey: "coverImage")
        aCoder.encode(self.publisher, forKey: "publisher")
        aCoder.encode(self.writer, forKey: "writer")
    }
    
    func getCoverImage(withURL imageURL: String) -> UIImage? {
        if let url = URL(string: imageURL) {
            if let imgData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imgData) {
                    return image
                }
            }
        }
        return nil
    }
}

