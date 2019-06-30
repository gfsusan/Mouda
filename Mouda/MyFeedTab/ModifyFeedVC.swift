//
//  ModifyFeedVC.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 10..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class ModifyFeedVC: AddFeedVC {

    var originalFeed: Feed?
    var indexPath: Int?
    var feedDetailDelegate: FeedDetailVC?
    
    @IBAction override func doneButtonPressed(_ sender: Any) {
        if let chosenBook = book {
            // line과 page 입력되었는지 확인. thought은 없어도 됨
            if lineTextView.textColor != UIColor.lightGray {
                if pageTextField.textColor != UIColor.lightGray {
                    var text:String
                    if thoughtTextView.textColor == UIColor.lightGray {
                        text = ""
                    } else {
                        text = thoughtTextView.text
                    }
                    // 새로운 피드 생성
                    let feed:Feed
                    guard let original = originalFeed else {
                        feed = Feed(book: chosenBook, page: Int(pageTextField.text!)!, line: lineTextView.text, thought: text)
                        showAlert(title: "삭제에 실패하였습니다.", message: "다시 시도해주세요.")
                        return
                    }
                    
                    feed = Feed(book: chosenBook, page: Int(pageTextField.text!)!, line: lineTextView.text, thought: text, date: original.date)
                   
                    
                    //델리게이트 업데이트
                    feedDetailDelegate?.feed = feed
                    
                    //데이터 센터 업데이트
                    if let index = indexPath {
                        dataCenter.delete(feed: original, at: index, sender: self)
                        dataCenter.add(feed: feed)
                    }
                    
                    // 저장 작업 외에는 Cancel과 똑같이 modal dismiss만 해주면 됨
                    cancelButtonPressed(sender)
                    
                } else { // page 입력 안됨
                    showAlert(title: "알림", message: "페이지를 입력해주세요.")
                    return
                }
            } else { // line 입력 안됨
                showAlert(title: "알림", message: "마음에 드는 문장을 입력해주세요.")
                return
            }
        } else { // 책 선택 안됨
            showAlert(title: "알림", message: "책을 선택해주세요.")
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let feed = originalFeed else {
            return
        }
        
        book = feed.book
        lineTextView.textColor = UIColor.black
        if thoughtTextView.text == "" {
            thoughtTextView.text = "기록한 문장에 대한 본인만의 생각이나 감정을 표현해주세요."
            thoughtTextView.textColor = UIColor.lightGray
        } else {
            thoughtTextView.textColor = UIColor.black
            thoughtTextView.text = feed.thought
        }
        lineTextView.text = feed.line
        pageTextField.text = "\(feed.page)"
        bookChooseButton.setTitle(feed.book.title, for: .normal)
        
    }
}
