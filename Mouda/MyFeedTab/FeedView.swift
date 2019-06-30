//
//  FeedView.swift
//  Mouda
//
//  Created by Susan Kim on 01/07/2019.
//  Copyright © 2019 cauadc. All rights reserved.
//

import UIKit

class FeedView: UIView {
    
    var feedViewModel: FeedViewModel? {
        didSet {
            updateView()
        }
    }
    
    var isSummaryMode: Bool = true {
        didSet {
            updateView()
        }
    }
    
    var isTitleVisible: Bool = true {
        didSet {
            updateView()
        }
    }
    
    private let penIconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .mySystemFont(ofSize: 16)
        return l
    }()
    
    private let dateLabel: UILabel = {
        let l = UILabel()
        l.font = .mySystemFont(ofSize: 11)
        l.textAlignment = .right
        return l
    }()
    
    private let lineLabel: UILabel = {
        let l = UILabel()
        l.font = .mySystemFont(ofSize: 15)
        l.textAlignment = .center
        //        let style = NSMutableParagraphStyle()
        //        style.lineSpacing = 5
        //        style.alignment = .center
        //        let attributes = [NSAttributedString.Key.paragraphStyle: style]
        //        l.lineLabel.attributedText = NSAttributedString(string: feed.line, attributes: attributes)
        return l
    }()
    
    private let pageLabel: UILabel = {
        let l = UILabel()
        l.font = .mySystemFont(ofSize: 14)
        l.textAlignment = .center
        return l
    }()
    
    private let thoughtLabel: UILabel = {
        let l = UILabel()
        l.font = .mySystemFont(ofSize: 14)
        l.textAlignment = .center
        //        let thoughtStyle = NSMutableParagraphStyle()
        //        thoughtStyle.lineSpacing = 5
        //        thoughtStyle.alignment = .center
        //        let thoughtAttributes = [NSAttributedString.Key.paragraphStyle: thoughtStyle]
        //        l.attributedText = NSAttributedString(string: feed.thought, attributes: thoughtAttributes)
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints() {
        let titleView = UIView()
        titleView.hstack(penIconView.withSize(.init(width: 24, height: 24)),
                         titleLabel,
                         dateLabel.withWidth(100),
                         spacing: 8)
        
        let lineView = UIView(backgroundColor: .lightGray)
        lineView.stack(lineLabel,
                       pageLabel.withHeight(40)
            ).withMargins(.init(top: 16, left: 16, bottom: 0, right: 16))
        
        let thoughtView = UIView()
        thoughtView.stack(thoughtLabel).withMargins(.init(top: 32, left: 8, bottom: 32, right: 8))
        
        if isSummaryMode {
            addSubview(lineView)
            addSubview(thoughtView)
            addSubview(titleView)
            
            titleView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,
                             padding: .init(top: 16, left: 8, bottom: 0, right: 8))
            lineView.anchor(top: titleView.centerYAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
            thoughtView.anchor(top: lineView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        } else {
            stack(stack(titleView).withMargins(.init(top: 16, left: 8, bottom: 0, right: 8)),
                  lineView,
                  thoughtView)
        }
        
        lineLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
        thoughtView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
    }
    
    func updateView() {
        subviews.forEach { (v) in
            v.removeFromSuperview()
        }
        
        penIconView.image = #imageLiteral(resourceName: "icons8-pen-100")
        titleLabel.text = feedViewModel?.title
        dateLabel.text = feedViewModel?.date
        lineLabel.text = feedViewModel?.line
        pageLabel.text = feedViewModel?.page
        thoughtLabel.text = feedViewModel?.thought
        
        configureConstraints()
        
        if isSummaryMode {
            lineLabel.numberOfLines = 4
            thoughtLabel.numberOfLines = 3
        } else {
            lineLabel.numberOfLines = 0
            thoughtLabel.numberOfLines = 0
        }
        
        if !isTitleVisible {
            penIconView.image = nil
            titleLabel.text = ""
            titleLabel.font = .mySystemFont(ofSize: 16)
        }
    }
}
