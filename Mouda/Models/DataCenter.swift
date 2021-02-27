//
//  DataCenter.swift
//  Mouda
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

let book1 = Book(title: "적을 만들지 않는 대화법", coverImageURL: "http://cfile5.uf.tistory.com/image/214D5C37583EE5952C31D0", publisher: "출판사1", writer: "작가1", bookDescription: "적을 만들지 않는 대화법을 알려주는 책이다.")
let book2 = Book(title: "필요한 사람인가", coverImageURL: "http://i2.media.daumcdn.net/svc/image/U03/news/201504/09/newsis/20150409141118025.jpeg", publisher: "출판사2", writer: "작가2", bookDescription: "필요한 사람인가에 대한 고찰")
let book3 = Book(title: "신경 끄기의 기술", coverImageURL: "http://image.yes24.com/momo/TopCate1638/MidCate004/163736954.jpg", publisher: "출판사3", writer: "작가3", bookDescription: "신경 끄는 기술에 대한 설명")
let book4 = Book(title: "인생극장", coverImageURL: "http://image.yes24.com/momo/TopCate1768/MidCate003/175796554.jpg", publisher: "출판사4", writer: "작가4", bookDescription: "사회학자인 아들이 대신 쓰는 부모의 자서전!")

let feed1 = Feed(book: book1, page: 10, line: "학교에서는 역사나 수학, 과학을 가르칠 뿐 갈등 해결 방법은 알려주지 않는다. 그리하여 사람들은 부당한 대우를 받았을 때 어떻게 해야 할지 모른다", thought: "작가의 아버지가 한 말처럼 \"제아무리 좋은 아이디어라도 실행하지 않는다면 쓰레기에 불과하다\".그래서 자연스럽게 익혀질 때까지 이 책을 반복해서 읽고 또 읽을 작정이다. 물론 늘 정답일 수는 없다. \"적을 없애는 방법은 친구로 만드는 것\"(p32)이라는 것을 알면서도 탐탁지 않아 적으로 남겨둔 채 링에서 내려온 적도 있고, 안 보면 그만이라는 식으로 돌아선 적도 있다. 그 놈의 성질, 그 놈의 마음 때문에 세련되게 대처할 기회를 놓쳤지만 앞으로의 인생은 좀 더 다르게 걸어볼 요량이므로 인내의 폭을 넓히기 위해 노력 중이다.", date: Date(timeIntervalSinceNow: -10000))
let feed2 = Feed(book: book2, page: 542, line: "아름답고 풍요로운 삶을 위해 인생 1막은 죽은 사람들과 대화를 즐겨라. \n고전에 힘입어 우리는 더 깊이 있고 참다운 인간이 된다. \n인생 2막은 살아 있는 사람들과 어울리며 세상의 좋은 것들을 즐겨라. \n조물주는 우리 모두에게 재능을 골고루 나누어주었고, \n때로는 탁월한 재능을 평범한 사람들에게 주었다. \n그들에게서 다양한 지식을 얻어라. \n인생 3막은 오로지 자신만을 위해서 보내라. \n행복한 철학자가 되는 것만큼 좋은 인생은 없다.", thought: "남에게 좋은 사람이 된다는 것은 무엇을 의미하는 걸까. 좋은 사람이라는 기준이라는 것 또한 세상이 만들어 놓은 잣대이며 그 잣대에 맞춰 살아가다보면 어쩔 수 없는 가면을 써야만 한다. 사회적 관계를 맺으며 살아가야 하는 우리는 태어나면서 누군가를 향한 페르소나를 쓴다. 진정한 나를 위함이 아닌 타인을 위해서 우리는 가면을 강요받기도 한다. 좋은 사람이라는 프레임이 가장 좋은 가면이다. 하지만, 타인과 좋은 관계를 맺기 위해 씌워진 가면을 조금씩 깨어야 할 때가 온다. 좋은 사람이라는 프레임은 나를 속박하는 무기로 작동되어 오히려 나를 나이게 살지 못하게 하는 요인이 되기도 한다. 좋은 사람 코스프레를 하다 남의 눈치를 보며 온갖 스트레스를 받다보면 우울증과 공황장애와 같은 정신질환을 앓게 되는 경우가 비일비재하게 발생한다.", date: Date(timeIntervalSinceNow: -500000))
let feed3 = Feed(book: book3, page: 53, line: "사람들이 자신의 문제를 부정하고 다른 사람을 비난하는 이유는 단순하다. 부정하거나 비난하는 일은 쉽고 즐겁지만, 문제를 해결하기는 힘들고 대체로 불쾌하기 때문이다. 비난과 부정이라는 방식을 선택하면 즉각적인 쾌감을 얻는다. 이것은 일시적으로 문제를 회피하는 길이며, 이런 회피의 길을 택하면 곧바로 짜릿한 쾌감을 얻을 수 있다.", thought: "저자는 또한 고통을 피할 방법은 없으니 다른 관점으로 바라봐야 한다고 한다. '우리 역시 문제를 다른 관점에서 바라보고 싶다면, 어디에 가치를 둘 것인지 그리고 어떤 기준을 실패와 성공을 가를 것인지를 다시 생각해 봐야 한다' 즉 가치를 어디에 두어야 할지를 말하는 것이다. 그러면서 두 사람의 사례를 비교하였는데, 메탈리카의 전 멤버인 데이브 메스테인과 비틀즈의 전 멤버 피트 베스트이다. 데이브 메스테인은 메가데스란 그룹으로 엄청난 명성과 성공을 얻었음에도, 메탈리카에 비해 부족하다는 인식에 실패했다고 느끼며 힘들어했던 반면, 피트 베스트는 음악가로서의 명성은 없었지만, 새로운 관점을 깨닫고 대가족과 함께 안락한 생활을 누리는 행복한 노인이 되었다. 결국 내 삶이 나아지려면 내 삶을 망치는 엉터리 가치에서 벗어나 좋은 가치에 신경 써야 한다.", date: Date(timeIntervalSinceNow: -1000000))
let feed4 = Feed(book: book4, page: 29, line: "아버지는 가장이었고, 가장으로 행세 했고, 가장으로 대접 받았다. 비록 형식적일지라도 집안의 중요한 결정은 아버지의 승인을 거쳐야 했다. 집에서 만큼은 ‘동굴 속의 황제’였기에 치매 걸린 아버지가 내지른 욕의 퍼레이드는 이상 증상이라기보다는 평상시 모습의 연장이라고 하는 게 맞다.", thought: "가부장제 가정의 한 단면을 보여 주는 일화다. 동굴 속의 황제처럼 가족 위에 군림한 아버지는 그 시대의 보편적인 아버지의 상이었다. 오래된 관습에 젖어 있는 모습을 치매에 걸려서도 여실히 보여 주고 있다.", date: Date(timeIntervalSinceNow: -1500000))

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
            feeds += [Feed(book: Book(title: "모으다에 오신 걸 환영합니다.", coverImageURL: "http://cfile5.uf.tistory.com/image/214D5C37583EE5952C31D0", publisher: "모으다", writer: "모으다개발자", bookDescription: "nothing"), page: 100, line: "'쓰다' 버튼을 터치해 간직하고 싶은 책 속의 한 문장을 작성해주세요.", thought: "기록한 문장에 대한 본인만의 생각이나 감정을 표현해보세요.")]
        }

        if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: Bookmark.ArchiveURL.path) as? [Bookmark] {
            print("북마크 파일 있음")
            bookmarks += unarchArray
        } else {
            print("북마크 파일 없음")
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
        
        defaultFeeds.append(feed1)
        defaultFeeds.append(feed2)
        defaultFeeds.append(feed3)
        defaultFeeds.append(feed4)
        
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
                if let sender = sender as? UIViewController {
                    sender.showAlert(title: "알림", message: "삭제에 실패하였습니다. 다시 시도해주세요.")
                }
            }
        } else {
            if let sender = sender as? UIViewController {
                sender.showAlert(title: "알림", message: "삭제에 실패하였습니다. 다시 시도해주세요.")
            }
        }
        
    }
    
    func delete(bookmarkOf book:Book, at index:Int, sender:Any?) {
        if index < self.bookmarks.count {
            let titleData = bookmarks[index].book.title
            if titleData == book.title{
                self.bookmarks.remove(at: index)
            } else {
                if let sender = sender as? UIViewController {
                    sender.showAlert(title: "알림", message: "삭제에 실패하였습니다. 다시 시도해주세요.")
                }
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

}
