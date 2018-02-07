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
        
        let book1 = Book(title: "적을 만들지 않는 대화법", coverImage: #imageLiteral(resourceName: "tempBook1"), publisher: "출판사1", writer: "작가1", bookDescription: "적을 만들지 않는 대화법을 알려주는 책이다.")
        let book2 = Book(title: "필요한 사람인가", coverImage: #imageLiteral(resourceName: "tempBook2"), publisher: "출판사2", writer: "작가2", bookDescription: "필요한 사람인가에 대한 고찰")
        let book3 = Book(title: "신경 끄기의 기술", coverImage: #imageLiteral(resourceName: "tempBook3"), publisher: "출판사3", writer: "작가3", bookDescription: "신경 끄는 기술에 대한 설명")
        
        let feed1 = Feed(book: book1, page: 12, line: "이기심은 자기 삶을 원하는 대로 사는 것이 아니다. 남들에게 자기가 원하는대로 살아달라고 요구하는 것이다.", thought: "이기적인 사람은 자기 마음대로 행동하는 사람이 아닌 자기가 원하는 대로 되게끔 행동하는 사람이다.")
        let feed2 = Feed(book: book2, page: 542, line: "남들에게 고마운 존재이기보다 필요한 존재가 되어라. 상대가 당신에게 고마워하기보다는 기대하고 의지하게 만들어라. 기대는 오랫동안 기억되지만 감사의 마음은 금방 사라지기 때문이다.", thought: "긴ㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ글ㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹ은ㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ길ㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹ엉ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ지ㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣ나ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ?")
        let feed3 = Feed(book: book3, page: 31, line: "조화를 이루시오 MMMMMMMMMMMMMMMM MMMMNMMNMNMNMNMNMNMNMNM NMNMMNNMNMNMNMNMNMNMNMN MNMNMNMNMNMNMNMNMNMNMNMN MNMNMNMNNMNMMMNMNMNMNMNMNMNMNM NMNMNMNMMNNMMNNMNMNMNMNMNMNMNMNMNMMNMNMNMNMNMNMNMNMNMN MNMNMNMNNMNMMMNMNMNMNMNMNMNMNM NMNMNMNMMNNMMNNMNMNMNMNMNMNMNMNMNMMNMNMNMNMNMNMNMNMNMN MNMNMNMNNMNMMMNMNMNMNMNMNMNMNM NMNMNMNMMNNMMNNMNMNMNMNMNMNMNMNMNMMNMNMNMNMNMNMNMNMNMN MNMNMNMNNMNMMMNMNMNMNMNMNMNMNM NMNMNMNMMNNMMNNMNMNMNMNMNMNMNMNMNM", thought: "신경끄자!")
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
