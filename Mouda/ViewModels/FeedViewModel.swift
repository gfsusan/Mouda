//
//  FeedViewModel.swift
//  Mouda
//
//  Created by Susan Kim on 01/07/2019.
//  Copyright © 2019 cauadc. All rights reserved.
//

import  UIKit
struct FeedViewModel {
    
    var title: String?
    var date: String
    var line: String
    var page: String
    var thought: String
    
    init(feed: Feed) {
        title = feed.book.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        date = dateFormatter.string(from: feed.date)
        
        line = feed.line
        page = "Page \(feed.page)"
        thought = feed.thought
    }
}
