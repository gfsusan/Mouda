//
//  DataCenter.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 7..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import Foundation

let dataCenter: DataCenter = DataCenter()
var fileName = "FeedData.brch"

class DataCenter {
    var feeds: [Feed] = []
    var filePath: String { get {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true).first!
        return documentDirectory + fileName
        }
    }
    
    // file 있으면 읽어오기, 없으면 초기 데이터 만들기
    init() {
        if FileManager.default.fileExists(atPath: self.filePath) {
            // read
            if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: self.filePath) as? [Feed] {
                feeds += unarchArray
            }

        } else {
            //create
            feeds += defaultData()
        }
//        feeds += defaultData()
    }
    
    func defaultData() -> Array<Feed> {
        var defaultFeed:[Feed] = []
        
        let feed1 = Feed()
        let feed2 = Feed()
        let feed3 = Feed()
        let feed4 = Feed(book: Book(), page: 321, line: "sfsdfsasdfasasfsfsafd", thought: "우와아아앙ㅇ")
        
        defaultFeed.append(feed1)
        defaultFeed.append(feed2)
        defaultFeed.append(feed3)
        defaultFeed.append(feed4)
        
        return defaultFeed
    }
    
    func save() {
        NSKeyedArchiver.archiveRootObject(self.feeds, toFile: self.filePath)
    }
}
