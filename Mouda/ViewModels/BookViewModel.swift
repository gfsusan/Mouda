//
//  BookViewModel.swift
//  Mouda
//
//  Created by Susan Kim on 2021/02/07.
//  Copyright © 2021 cauadc. All rights reserved.
//
import UIKit

class BookViewModel {
    var title: String
    var author: String
    var publisher: String
    var coverImage: UIImage?
    
    init(book: Book) {
        title = book.title ?? ""
        author = book.writer ?? ""
        publisher = book.publisher ?? ""
        coverImage = book.coverImage
    }
}
