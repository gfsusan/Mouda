//
//  DataCenter.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 7..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import Foundation
import UIKit
import os.log

let dataCenter: DataCenter = DataCenter()
var feedDataFileName = "FeedData.brch"
var bookmarkDataFileName = "BookmarkData.brch"
var alarmDelegate:AlarmVC?

let book1 = Book(title: "적을 만들지 않는 대화법", coverImageURL: "http://cfile5.uf.tistory.com/image/214D5C37583EE5952C31D0", publisher: "출판사1", writer: "작가1", bookDescription: "적을 만들지 않는 대화법을 알려주는 책이다.")
let book2 = Book(title: "필요한 사람인가", coverImageURL: "http://i2.media.daumcdn.net/svc/image/U03/news/201504/09/newsis/20150409141118025.jpeg", publisher: "출판사2", writer: "작가2", bookDescription: "필요한 사람인가에 대한 고찰")
let book3 = Book(title: "신경 끄기의 기술", coverImageURL: "http://image.yes24.com/momo/TopCate1638/MidCate004/163736954.jpg", publisher: "출판사3", writer: "작가3", bookDescription: "신경 끄는 기술에 대한 설명")
let book4 = Book(title: "인생극장", coverImageURL: "http://image.yes24.com/momo/TopCate1768/MidCate003/175796554.jpg", publisher: "출판사4", writer: "작가4", bookDescription: "사회학자인 아들이 대신 쓰는 부모의 자서전!")

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
        // 피드 파일 존재하는지 확인
        if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: Feed.ArchiveURL.path) as? [Feed] {
            print("피드 파일 있음")
            feeds += unarchArray


        } else {
            print("피드 파일 없음")
            feeds += defaultFeedData()
        }


        if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: Bookmark.ArchiveURL.path) as? [Bookmark] {
            print("북마크 파일 있음")
            bookmarks += unarchArray
        } else {
            print("북마크 파일 없음")
            bookmarks += defaultBookmarkData()
        }

        // dummy data
//        feeds += defaultFeedData()
//        bookmarks += defaultBookmarkData()
        
//        for feed in feeds {
//            books.append(feed.book)
//        }
        // 데이터 소팅
        self.sortFeed()
    }
    
    func defaultFeedData() -> Array<Feed> {
        var defaultFeeds:[Feed] = []
    
        let feed1 = Feed(book: book1, page: 12, line: "이기심은 자기 삶을 원하는 대로 사는 것이 아니다. 남들에게 자기가 원하는대로 살아달라고 요구하는 것이다.", thought: "이기적인 사람은 자기 마음대로 행동하는 사람이 아닌 자기가 원하는 대로 되게끔 행동하는 사람이다.", date: Date(timeIntervalSince1970: 1513111111))
        let feed2 = Feed(book: book2, page: 542, line: "남들에게 고마운 존재이기보다 필요한 존재가 되어라. 상대가 당신에게 고마워하기보다는 기대하고 의지하게 만들어라. 기대는 오랫동안 기억되지만 감사의 마음은 금방 사라지기 때문이다.", thought: "전날 연습에서 강릉 아이스아레나의 경기장 적응에 중점을 뒀던 대표팀은 이날 연습에서는 스피드를 올리며 본격적 대회 준비에 나섰다.\n 선수들은 훈련 중간에 노트북으로 전송된 훈련 장면 영상을 확인하며 감독, 코치에게 교정을 받고 선수들끼리 자주 이야기도 나눴다.\n 연습 이틀째를 맞이하며 빙질 적응도 끝냈다.\n 최민정은 “얼음 상태가 전반적으로 딱딱한 편이다.\n 내 스케이팅과도 잘 맞는다”고 만족감을 드러냈다.", date: Date(timeIntervalSince1970: 1514511111))
        let feed3 = Feed(book: book3, page: 31, line: "조화를 이루시오 한국은 오랫동안 동계스포츠 불모지였다.\n올림픽 첫 금메달도 16번째 대회인 1992년 알베르빌올림픽에서 겨우 따냈다. 그러나 이후부터는 사정이 달라졌다.\n신생 종목인 쇼트트랙에서 한국이 압도적 성적을 냈기 때문이다.\n한국 쇼트트랙은 알베르빌부터 소치까지 7번의 올림픽에서 8차례나 다관왕을 배출했다.\n2006 토리노올림픽 때는 안현수, 진선유가 3관왕에 올랐고 2010 밴쿠버올림픽에서도 이정수가 2관왕을 달성해 한국이 역대 최고 성적인 5위에 오르는 데에 결정적인 기여를 했다.\n밴쿠버를 넘어서는 종합 4위를 노리는 한국대표팀에게 쇼트트랙에서의 또 한 번의 다관왕 배출은 무엇보다 중요하다.\n한국의 아홉 번째 다관왕 후보로 첫손에 꼽히는 선수가 최민정(20·성남시청)이다.\n7일 오전 강릉 아이스아레나에서 열린 대표팀의 이틀째 훈련에 나선 최민정의 몸은 매우 가벼워 보였다.\n스스로도 “컨디션이 만족할 정도로 올라왔다”며 자신감을 나타낼 정도다. ", thought: "신경끄자!", date: Date(timeIntervalSince1970: 1515211111))
//        let feed4 = Feed(book: book4, page: 321, line: "프롤로그 _ 순간이 모여 인생을 이루다 내던져진, 그리고 갇혀버린 우리\n역사로 자기 인생을 기록하는 영웅과 이름 없는 필부\n인생을 심정으로 표현하는 ‘그저 그런’ 사람들\n욕으로 정리되는 20세기: 아버지의 마지막 증상\n마지막까지 가만가만한 한탄: 어머니라는 여성의 성격학적 증상\n자식조차 그들의 인생을 묻지 않았다\n아들이 대신 쓰는 자서전\n기록도 자료도 없는 보통 사람의 삶은 어떻게 복원될 수 있을까\n심층 소망으로 들어가는 입구: 시네마 파라디소\n과거로의 여행기 ", thought: "1924년생 아버지, 1936년생 어머니. \n일제강점기에 태어나 전쟁을 겪고 급격한 산업화와 경제성장을 이룬 세대가 공유한 사회적 운명이 새겨져 있는, 역사가 특별히 기록할 리 없는 전형적인 ‘한국 남자’였고, \n자식 교육에 모든 것을 걸었던, 역시 특별할 것 없는 전형적인 ‘한국 여자’였던 부모의 삶을 복원하기 위해 저자는 1920~70년대 한국 대중영화를 소재로 삼았다.", date: Date(timeIntervalSince1970: 1513811111))
        
        defaultFeeds.append(feed1)
        defaultFeeds.append(feed2)
        defaultFeeds.append(feed3)
//        defaultFeeds.append(feed4)
        
        
        return defaultFeeds
    }
    
    func defaultBookmarkData() -> Array<Bookmark> {
        var defaultBookmarks:[Bookmark] = []
        
        for feed in feeds {
            defaultBookmarks.append(Bookmark(book: feed.book, page: feed.page))
        }
        
        return defaultBookmarks
    }
    
    func save() {
        print("save data")
        let isFeedSuccessfulSave = NSKeyedArchiver.archiveRootObject(feeds, toFile: Feed.ArchiveURL.path)
        let isBookmarkSuccessfulSave = NSKeyedArchiver.archiveRootObject(bookmarks, toFile: Bookmark.ArchiveURL.path)
        
        if isFeedSuccessfulSave {
            os_log("Feeds successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save feeds...", log: OSLog.default, type: .error)
        }
        
        if isBookmarkSuccessfulSave {
            os_log("Bookmarks successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save bookmarks...", log: OSLog.default, type: .error)
        }

//        NSKeyedArchiver.archiveRootObject(self.feeds, toFile: self.feedFilePath)
//        NSKeyedArchiver.archiveRootObject(self.bookmarks, toFile: self.bookmarkFilePath)
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
            bookmarks.insert(Bookmark(book: book, page: feed.page), at: 0)
        }
        feeds.append(feed)
        self.sortFeed()
        self.save()
    }
    
    func sortFeed() {
        feeds.sort(by: {$0.date.timeIntervalSince1970 > $1.date.timeIntervalSince1970})

    }
    
    func add(bookmark: Bookmark) {
        self.bookmarks.insert(bookmark, at: 0)
        self.save()
    }
    
    func delete(feedAt index:Int) {
        self.feeds.remove(at: index)
        self.save()
    }
    
    func delete(feed:Feed, at index:Int, sender:Any?) {
        // index 유효한지 체크
        if index < self.feeds.count {
            let lineData = feeds[index].line
            if lineData == feed.line {
                self.feeds.remove(at: index)
            } else {
                createAlert(title: "알림", message: "삭제에 실패하였습니다. 다시 시도해주세요.", sender: sender)
            }
        } else {
            createAlert(title: "알림", message: "삭제에 실패하였습니다. 다시 시도해주세요.", sender: sender)
        }
        
    }
    
    func delete(bookmarkOf book:Book, at index:Int, sender:Any?) {
        if index < self.bookmarks.count {
            let titleData = bookmarks[index].book.title
            if titleData == book.title{
                self.bookmarks.remove(at: index)
            } else {
                createAlert(title: "알림", message: "삭제에 실패하였습니다. 다시 시도해주세요.", sender: sender)
            }
        }
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
    
    func createAlert (title:String, message:String, sender:Any?) {
        let alert = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"OK", style:UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print("OK")
        }))
        
        if let delegate = sender as? UIViewController {
            delegate.present(alert, animated: true, completion: nil)
        }
    }
    

}
