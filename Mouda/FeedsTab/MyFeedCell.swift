//
//  MyFeedCell.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 2..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class MyFeedCell: UITableViewCell {
    
    var feedViewModel: FeedViewModel? {
        didSet {
            feedView.feedViewModel = feedViewModel
        }
    }
    
    let feedView: FeedView = {
        let v = FeedView()
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints() {
        addSubview(feedView)
        feedView.fillSuperview()
    }
}
