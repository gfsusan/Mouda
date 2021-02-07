//
//  BookView.swift
//  Mouda
//
//  Created by Susan Kim on 2021/02/06.
//  Copyright © 2021 cauadc. All rights reserved.
//

import UIKit

class BookView: UIView {

    var bookViewModel: BookViewModel? {
        didSet {
            updateView()
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stack(
            hstack(bookImageView,
                   stack(titleLabel,
                         publisherLabel,
                         authorLabel,
                         distribution: .fillEqually),
                   spacing: 12)
            ).withMargins(.init(top: 24, left: 8, bottom: 24, right: 8)).withHeight(168)
        backgroundColor = .groupTableViewBackground
        
        bookImageView.widthAnchor.constraint(equalTo: bookImageView.heightAnchor, multiplier: 0.75).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView() {
        bookImageView.image = bookViewModel?.coverImage
        titleLabel.text = bookViewModel?.title
        publisherLabel.text = bookViewModel?.publisher
        authorLabel.text = bookViewModel?.author
    }
    
}
