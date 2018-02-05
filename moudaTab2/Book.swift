//
//  Book.swift
//  초안
//
//  Created by cauadc on 2018. 1. 30..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import Foundation
import UIKit

class Book {
    var title:String
    var coverImage:UIImage?
    var publisher:String?
    var writer:String?
    var description:String?
//    var url:String?
    
    init(title:String) {
        self.title = title
    }
}

