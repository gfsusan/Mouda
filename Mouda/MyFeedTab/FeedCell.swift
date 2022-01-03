//
//  FeedCell.swift
//  Mouda
//
//  Created by Susan Kim on 2021/03/17.
//  Copyright © 2021 cauadc. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    var feedViewModel: FeedViewModel? {
        didSet {
            feedView.feedViewModel = feedViewModel
        }
    }
    
    var feedView = FeedView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(feedView)
        feedView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
