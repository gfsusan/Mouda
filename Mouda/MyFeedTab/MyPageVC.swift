//
//  MyPageVC.swift
//  Mouda
//
//  Created by Susan Kim on 2021/03/17.
//  Copyright © 2021 cauadc. All rights reserved.
//

import UIKit

class MyPageVC: ViewController {
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 40
        
        return iv
    }()
    
    let postCountLabel: CountLabel = {
        let cl = CountLabel()
        cl.count = 80
        cl.title = "게시물"
        return cl
    }()

    let followerCountLabel: CountLabel = {
        let cl = CountLabel()
        cl.count = 120
        cl.title = "팔로워"
        return cl
    }()
    
    let followingCountLabel: CountLabel = {
        let cl = CountLabel()
        cl.count = 178
        cl.title = "팔로잉"
        return cl
    }()
    
    let introductionLabel: UILabel = {
        let l = UILabel()
        l.text = "안녕하세요오오오오오오오오오얼미ㅑㅓ랴인머ㅑ인러ㅣㄴ야ㅓ댬ㄴ럳냐ㅣ럳내ㅑ럳내ㅑ럳ㅁ내ㅑ러먀ㅐㄴ러ㅐㅑㄴㄷ러ㅑㅐㄴㄷ러ㅑㅐㄴ러아ㅣㄴㅁ러ㅏㅣㄴ어라인러나임러ㅏㄴ이러ㅏㄴ임러냐ㅓ댜ㅣㄴ먿니"
        l.numberOfLines = 0
        return l
    }()
    
    let editButton: UIButton = {
       let b = UIButton()
        b.setTitle("프로필 편집", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.layer.borderWidth = 1
        b.layer.cornerRadius = 8
        return b
    }()
    
    let menuBar = MenuBar()
    let feedCollectionView = FeedCollectionView()
    let collectionView = UICollectionView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureConstraints()
    }
    
    override func configureConstraints() {
        let countStack = view.hstack(
            postCountLabel,
            followerCountLabel,
            followingCountLabel
        )
        
        view.stack(
            UIView().withHeight(100),
            view.hstack(
                profileImageView.withSize(.init(width: 80, height: 80)),
                countStack
                ),
            introductionLabel,
            editButton,
            menuBar.withHeight(40),
            feedCollectionView
        )
    }
}
