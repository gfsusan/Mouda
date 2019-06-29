//
//  BookmarkCollectionVC.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 9..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit


class BookmarkCollectionVC: UICollectionViewController {

    var bookmarks:[Bookmark] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Logo"))
        imageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bookmarks = dataCenter.bookmarks
        self.collectionView?.reloadData()
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = collectionView?.indexPathsForSelectedItems?.first {
            if indexPath.row > 0 {
                
            }
        }
    }
 

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return bookmarks.count + 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row > 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookmarkCell", for: indexPath) as? BookmarkCell
            
            guard let retCell = cell else {
                return cell!
            }
            
            // 인덱스가 Add Boookmark Cell때문에 한칸 밀리기 때문에
            let bookmarkIndex = indexPath.row - 1
            
            let bookmark = bookmarks[bookmarkIndex]
            
            if let thumbImage = bookmark.book.coverImage {
                retCell.coverImage.image = thumbImage
            } else {
                retCell.coverImage.image = UIImage(named: "book2")
                if let thumbImageURL = bookmark.book.coverImageURL {
                    DispatchQueue.main.async(execute: {
                        bookmark.book.coverImage = bookmark.book.getCoverImage(withURL: thumbImageURL)
                        guard let thumbImage = bookmark.book.coverImage else {
                            return
                        }
                        retCell.coverImage.image = thumbImage
                    })
                }
            }
            
            if let page = bookmark.pageMark {
                retCell.pageLabel.text = "\(page)쪽까지 읽음"
            } else {
                retCell.pageLabel.text = "다 읽음"
            }
            
            return retCell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookmarkAddCell", for: indexPath)
            
            return cell
        }
    
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
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

}
