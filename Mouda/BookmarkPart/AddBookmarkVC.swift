//
//  AddBookmarkViewController.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 7..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class AddBookmarkVC: AddFeedVC {
    
    var delegate: BookmarkCollectionVC?
    
    var page: Int?
    override var book: Book? {
        didSet {
           bookChooseButton.setTitle("다시 선택", for: .normal)
        }
    }
    
    let pageView = PageView()
    
    override func viewWillAppear(_ animated: Bool) {
        bookView.bookImageView.image = book?.coverImage
        bookView.titleLabel.text = book?.title
        bookView.publisherLabel.text = book?.publisher
        bookView.authorLabel.text = book?.writer
    }
    
    override func doneButtonPressed(_ sender: Any) {
        if let selectedBook = book {
            if let pageText = pageView.pageTextField.text {
                if let page = Int(pageText) {
                    if dataCenter.hasBookmark(of: selectedBook) == false{
                        dataCenter.add(bookmark: Bookmark(book: selectedBook, page: page))
                        self.dismiss(animated: true, completion: nil)
                    }
                    else {
                        showAlert(title: "이미 북마크가 있어요!", message: "")
                        return
                    }
                } else {
                    showAlert(title: "페이지를 입력해주세요.", message: "")
                    return
                }
            }

        } else {
            showAlert(title: "책을 선택하지 않으셨네요.", message: "책 선택 버튼을 눌러 책을 선택해주세요!")
            return
        }
    }

    override func configureConstraints() {
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
                
        let contentView = UIView()
        contentView.stack(bookChooseButton.withHeight(60),
                          bookView,
                          pageView,
                          spacing: 8
        ).withMargins(.init(top: 8, left: 0, bottom: 0, right: 0))
        
        scrollView.addSubview(contentView)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor)
        
        scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }
}
