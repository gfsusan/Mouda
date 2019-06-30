//
//  BookmarkCell.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 9..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class BookmarkCell: UICollectionViewCell {
    
    var bookmarkViewModel: BookmarkViewModel? {
        didSet {
            pageLabel.text = bookmarkViewModel?.page
            if let imageUrl = bookmarkViewModel?.coverImageUrl {
                coverImage.loadImageUsingUrlString(imageUrl: imageUrl)
            }
        }
    }
    
    let coverImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    private let pageLabel: UILabel = {
        let l = UILabel()
        l.font = .mySystemFont(ofSize: 13)
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray

        let stackView = stack(coverImage.withWidth(100),
              pageLabel.withHeight(20),
              spacing: 8).withMargins(.init(top: 15, left: 0, bottom: 8, right: 0)
            )
        
        stackView.alignment = .center
//
//        coverImage.heightAnchor.constraint(equalTo: coverImage.widthAnchor, multiplier: 4/3.0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
