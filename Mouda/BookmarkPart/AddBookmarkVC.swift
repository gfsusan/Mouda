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

    let bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()

    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20)
        return l
    }()
    
    let publisherLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        return l
    }()
    
    let authorLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        return l
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        bookImageView.image = book?.coverImage
        titleLabel.text = book?.title
        publisherLabel.text = book?.publisher
        authorLabel.text = book?.writer
    }
    
    override func doneButtonPressed(_ sender: Any) {
        if let selectedBook = book {
            if let pageText = pageTextField.text {
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
        
        let bookView = UIView()
        bookView.stack(
            view.hstack(bookImageView,
                        view.stack(titleLabel,
                                   publisherLabel,
                                   authorLabel,
                                   distribution: .fillEqually),
                        spacing: 12)
            ).withMargins(.init(top: 24, left: 8, bottom: 24, right: 8)).withHeight(168)
        bookView.backgroundColor = .groupTableViewBackground
        bookImageView.widthAnchor.constraint(equalTo: bookImageView.heightAnchor, multiplier: 0.75).isActive = true
        
        let pageView = UIView()
        pageView.hstack(UIView(),
                        pageTextField,
                        UIView(),
                        distribution: .equalCentering
            ).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8)).withHeight(44)
        pageTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
        pageView.backgroundColor = .groupTableViewBackground
        
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
