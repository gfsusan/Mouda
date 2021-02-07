//
//  ModifyFeedVC.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 10..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class ModifyFeedVC: AddFeedVC {

    var originalFeed: Feed? {
        didSet {
            updateView()
        }
    }
    var indexPath: Int?
    var feedDetailDelegate: FeedDetailVC?
    
    override func handleSave(feed: Feed) {
        guard let original = originalFeed else {
            showAlert(title: "기존 피드를 찾을 수 없습니다.", message: "삭제에 실패하였습니다. 다시 시도해주세요.")
            return
        }
        
        //델리게이트 업데이트
        feedDetailDelegate?.feed = feed
        
        //데이터 센터 업데이트
        if let index = indexPath {
            dataCenter.delete(feed: original, at: index, sender: self)
            dataCenter.add(feed: feed)
        }
        
        // 저장 작업 외에는 Cancel과 똑같이 modal dismiss만 해주면 됨
        handleClose()
    }

    func updateView() {
        guard let feed = originalFeed else {
            bookChooseButton.setTitle("+ 책 선택", for: .normal)
            return
        }
        
        book = feed.book
        
        let feedViewModel = FeedViewModel(feed: feed)
        thoughtTextView.text = feedViewModel.thought
        lineTextView.text = feedViewModel.line
        pageInputView.pageTextField.text = feedViewModel.page
    }
}
