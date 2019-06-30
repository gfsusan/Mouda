//
//  FeedView.swift
//  Mouda
//
//  Created by Susan Kim on 01/07/2019.
//  Copyright © 2019 cauadc. All rights reserved.
//

import UIKit

class FeedView: UIView {
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .mySystemFont(ofSize: 16)
        return l
    }()
    
    let lineLabel: UILabel = {
        let l = UILabel()
        l.font = .mySystemFont(ofSize: 15)
        l.textAlignment = .center
        l.numberOfLines = 4
        //        let style = NSMutableParagraphStyle()
        //        style.lineSpacing = 5
        //        style.alignment = .center
        //        let attributes = [NSAttributedString.Key.paragraphStyle: style]
        //        l.lineLabel.attributedText = NSAttributedString(string: feed.line, attributes: attributes)
        return l
    }()
    
    let dateLabel: UILabel = {
        let l = UILabel()
        l.font = .mySystemFont(ofSize: 11)
        l.textAlignment = .right
        return l
    }()
    
    let pageLabel: UILabel = {
        let l = UILabel()
        l.font = .mySystemFont(ofSize: 14)
        l.textAlignment = .center
        return l
    }()
    
    let thoughtLabel: UILabel = {
        let l = UILabel()
        l.font = .mySystemFont(ofSize: 14)
        l.textAlignment = .center
        l.numberOfLines = 3
        //        let thoughtStyle = NSMutableParagraphStyle()
        //        thoughtStyle.lineSpacing = 5
        //        thoughtStyle.alignment = .center
        //        let thoughtAttributes = [NSAttributedString.Key.paragraphStyle: thoughtStyle]
        //        l.attributedText = NSAttributedString(string: feed.thought, attributes: thoughtAttributes)
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints() {
        let penIconView = UIImageView(image: #imageLiteral(resourceName: "icons8-pen-100"))
        penIconView.contentMode = .scaleAspectFit
        
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
        
        addSubview(lineView)
        addSubview(thoughtView)
        addSubview(titleView)
        
        titleView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,
                         padding: .init(top: 16, left: 8, bottom: 0, right: 8))
        lineView.anchor(top: titleView.centerYAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        thoughtView.anchor(top: lineView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        lineLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
        thoughtView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
    }
}
