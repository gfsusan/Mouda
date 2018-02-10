//
//  DataCenter.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 7..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import Foundation

let dataCenter: DataCenter = DataCenter()
var feedDataFileName = "FeedData.brch"
var bookmarkDataFileName = "BookmarkData.brch"

let book1 = Book(title: "적을 만들지 않는 대화법", coverImageURL: "http://bookthumb.phinf.naver.net/cover/126/921/12692139.jpg?type=m1&udate=20171102", publisher: "출판사1", writer: "작가1", bookDescription: "적을 만들지 않는 대화법을 알려주는 책이다.")
let book2 = Book(title: "필요한 사람인가", coverImageURL: "http://i2.media.daumcdn.net/svc/image/U03/news/201504/09/newsis/20150409141118025.jpeg", publisher: "출판사2", writer: "작가2", bookDescription: "필요한 사람인가에 대한 고찰")
let book3 = Book(title: "신경 끄기의 기술", coverImageURL: "http://image.yes24.com/momo/TopCate1638/MidCate004/163736954.jpg", publisher: "출판사3", writer: "작가3", bookDescription: "신경 끄는 기술에 대한 설명")

class DataCenter {
    var feeds: [Feed] = []
    var bookmarks: [Bookmark] = []
    // search 위해서 걍 만들어놓은 dummy data
    var books: [Book] = []
    
    var feedFilePath: String { get {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return documentDirectory + feedDataFileName
        }
    }
    
    var bookmarkFilePath: String { get {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return documentDirectory + bookmarkDataFileName
        }
    }
    
    // file 있으면 읽어오기, 없으면 초기 데이터 만들기
    init() {
        
        // dummy data
        books.append(book1)
        books.append(book2)
        books.append(book3)
        
//        // 피드 파일 존재하는지 확인
//        if FileManager.default.fileExists(atPath: self.feedFilePath) {
//            print("피드 파일 있음")
//            if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: self.feedFilePath) as? [Feed] {
//                feeds += unarchArray
//            }
//
//        } else {
//            print("피드 파일 없음")
//            feeds += defaultFeedData()
//        }
//
//        if FileManager.default.fileExists(atPath: self.bookmarkFilePath) {
//            // read
//            print("북마크 파일 있음")
//            if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: self.bookmarkFilePath) as? [Bookmark] {
//                bookmarks += unarchArray
//            }
//        } else {
//            print("북마크 파일 없음")
//            bookmarks += defaultBookmarkData()
//        }
//        dummy data
        feeds += defaultFeedData()
        bookmarks += defaultBookmarkData()
    }
    
    func defaultFeedData() -> Array<Feed> {
        var defaultFeeds:[Feed] = []
    
        let feed1 = Feed(book: book1, page: 12, line: "이기심은 자기 삶을 원하는 대로 사는 것이 아니다. 남들에게 자기가 원하는대로 살아달라고 요구하는 것이다.", thought: "이기적인 사람은 자기 마음대로 행동하는 사람이 아닌 자기가 원하는 대로 되게끔 행동하는 사람이다.")
        let feed2 = Feed(book: book2, page: 542, line: "남들에게 고마운 존재이기보다 필요한 존재가 되어라. 상대가 당신에게 고마워하기보다는 기대하고 의지하게 만들어라. 기대는 오랫동안 기억되지만 감사의 마음은 금방 사라지기 때문이다.", thought: "전날 연습에서 강릉 아이스아레나의 경기장 적응에 중점을 뒀던 대표팀은 이날 연습에서는 스피드를 올리며 본격적 대회 준비에 나섰다.\n 선수들은 훈련 중간에 노트북으로 전송된 훈련 장면 영상을 확인하며 감독, 코치에게 교정을 받고 선수들끼리 자주 이야기도 나눴다.\n 연습 이틀째를 맞이하며 빙질 적응도 끝냈다.\n 최민정은 “얼음 상태가 전반적으로 딱딱한 편이다.\n 내 스케이팅과도 잘 맞는다”고 만족감을 드러냈다.")
        let feed3 = Feed(book: book3, page: 31, line: "조화를 이루시오 한국은 오랫동안 동계스포츠 불모지였다.\n 올림픽 첫 금메달도 16번째 대회인 1992년 알베르빌올림픽에서 겨우 따냈다. 그러나 이후부터는 사정이 달라졌다.\n 신생 종목인 쇼트트랙에서 한국이 압도적 성적을 냈기 때문이다.\n 한국 쇼트트랙은 알베르빌부터 소치까지 7번의 올림픽에서 8차례나 다관왕을 배출했다.\n 2006 토리노올림픽 때는 안현수, 진선유가 3관왕에 올랐고 2010 밴쿠버올림픽에서도 이정수가 2관왕을 달성해 한국이 역대 최고 성적인 5위에 오르는 데에 결정적인 기여를 했다.\n 밴쿠버를 넘어서는 종합 4위를 노리는 한국대표팀에게 쇼트트랙에서의 또 한 번의 다관왕 배출은 무엇보다 중요하다.\n 한국의 아홉 번째 다관왕 후보로 첫손에 꼽히는 선수가 최민정(20·성남시청)이다.\n 7일 오전 강릉 아이스아레나에서 열린 대표팀의 이틀째 훈련에 나선 최민정의 몸은 매우 가벼워 보였다.\n 스스로도 “컨디션이 만족할 정도로 올라왔다”며 자신감을 나타낼 정도다. ", thought: "신경끄자!")
        let feed4 = Feed(book: Book(), page: 321, line: "sfsdfsasdfasasfsfsafd", thought: "우와아아앙ㅇ")
        
        defaultFeeds.append(feed1)
        defaultFeeds.append(feed2)
        defaultFeeds.append(feed3)
        defaultFeeds.append(feed4)
        
        
        return defaultFeeds
    }
    
    func defaultBookmarkData() -> Array<Bookmark> {
        var defaultBookmarks:[Bookmark] = []
        
        let bookmark1 = Bookmark(book: book1, page: 135)
        let bookmark2 = Bookmark(book: book2, page: 246)
        let bookmark3 = Bookmark(book: book3, page: 579)
        
        defaultBookmarks.append(bookmark1)
        defaultBookmarks.append(bookmark2)
        defaultBookmarks.append(bookmark3)
        
        return defaultBookmarks
    }
    
    func save() {
        print("save data")
        NSKeyedArchiver.archiveRootObject(self.feeds, toFile: self.feedFilePath)
        NSKeyedArchiver.archiveRootObject(self.bookmarks, toFile: self.bookmarkFilePath)
    }
    
    func feeds(of book:Book) -> Array<Feed> {
        var feeds:[Feed] = []
        for feed in self.feeds {
            if feed.book.title == book.title {
                feeds.append(feed)
            }
        }
        return feeds
    }
    
    func add(feed:Feed) {
        let book = feed.book
        if self.hasBookmark(of: book) == false {
            bookmarks.insert(Bookmark(book: book, page: 0), at: 0)
        }
        feeds.insert(feed, at: 0)
        
        self.save()
    }
    
    func add(bookmark: Bookmark) {
        self.bookmarks.insert(bookmark, at: 0)
    }
    
    func hasBookmark(of book:Book) -> Bool {
        let title = book.title
        for bookmark in bookmarks {
            if bookmark.book.title == title {
                return true
            }
        }
        return false
        
    }
    

}
