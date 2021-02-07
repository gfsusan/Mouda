//
//  BookmarkViewModel.swift
//  Mouda
//
//  Created by Susan Kim on 01/07/2019.
//  Copyright © 2019 cauadc. All rights reserved.
//

import Foundation

struct BookmarkViewModel {
    var coverImageUrl: String?
    var page: String
    
    init(bookmark: Bookmark?) {
        guard let bookmark = bookmark else {
            coverImageUrl = nil
            page = "책갈피 추가"
            return
        }
        
        if let pageMark = bookmark.pageMark {
            page = "\(pageMark)쪽까지 읽음"
        } else {
            page = "다 읽음"
        }
        
        coverImageUrl = bookmark.book.coverImageURL
    }
}
