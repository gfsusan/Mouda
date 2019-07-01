//
//  BookmarkCollectionVC.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 9..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

private let cellId = "bookmarkCellId"
private let addCellId = "addBookmarkCellId"

class BookmarkCollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var bookmarks:[Bookmark] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Logo"))
        imageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        // Settings button
        let settingsButton = UIBarButtonItem(image: #imageLiteral(resourceName: "setting"), style: .plain, target: self, action: #selector(showSetting))
        navigationItem.rightBarButtonItem = settingsButton
        
        let invisibleButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Empty"), style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = invisibleButton
        
        collectionView.register(BookmarkCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(BookmarkCell.self, forCellWithReuseIdentifier: addCellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bookmarks = dataCenter.bookmarks
        self.collectionView?.reloadData()
    }
    
    @objc func showSetting() {
        let storyboard = UIStoryboard(name: "Setting", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "settings")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookmarks.count + 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item > 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? BookmarkCell else { return UICollectionViewCell() }
            
            // 인덱스가 Add Boookmark Cell때문에 한칸 밀리기 때문에
            let bookmarkIndex = indexPath.row - 1
            
            let bookmark = bookmarks[bookmarkIndex]
            
            cell.bookmarkViewModel = BookmarkViewModel(bookmark: bookmark)
            
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addCellId, for: indexPath) as? BookmarkCell else { return UICollectionViewCell() }
            
            cell.bookmarkViewModel = BookmarkViewModel(bookmark: nil)
            cell.coverImage.backgroundColor = .white
            cell.coverImage.contentMode = .scaleAspectFit
            cell.coverImage.image = #imageLiteral(resourceName: "LaunchLogo")
            
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let addBookmarkVC = AddBookmarkVC()
            addBookmarkVC.delegate = self
            let navContr = UINavigationController(rootViewController: addBookmarkVC)
            
            self.present(navContr, animated: true)
        } else {
            // Add bookmark cell 때문에 1 밀림
            let bookmarkIndex = indexPath.row - 1;
            
            let bookFeedVC = BookFeedVC()
            bookFeedVC.bookmark = bookmarks[bookmarkIndex]
            bookFeedVC.indexPath = bookmarkIndex
            navigationController?.pushViewController(bookFeedVC, animated: true)
        }
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    
    let spacing: CGFloat = 20
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - (spacing * 3)) / 2.0
        let height = width * (4 / 3.0)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }
}
