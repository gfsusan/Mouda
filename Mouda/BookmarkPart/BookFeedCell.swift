//
//  BookFeedCell.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 10..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class BookFeedCell: UITableViewCell {

    let dateLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    let lineLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    let pageLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    let thoughtLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        stack(dateLabel,
              lineLabel,
              pageLabel,
              thoughtLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
