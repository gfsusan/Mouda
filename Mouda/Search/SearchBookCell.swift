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
        l.font = .systemFont(ofSize: 20)
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
        
        let labelsStackView = UIStackView(arrangedSubviews: [titleTV, writerTV])
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [bookImageView, labelsStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            bookImageView.widthAnchor.constraint(equalTo: bookImageView.heightAnchor, multiplier: 0.75),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
