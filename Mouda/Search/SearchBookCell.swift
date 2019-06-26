//
//  SearchBookCell.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 8..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class SearchBookCell: UITableViewCell {

    let bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let titleTV: UILabel = {
        let l = UILabel()
        l.font = .myBoldSystemFont(ofSize: 20)
        l.minimumScaleFactor = 0.7
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    let writerTV: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 17)
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        hstack(
            bookImageView,
            stack(titleTV,
                    writerTV,
                    distribution: .fillEqually),
              spacing: 16).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
        
        bookImageView.widthAnchor.constraint(equalTo: bookImageView.heightAnchor, multiplier: 0.75).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
