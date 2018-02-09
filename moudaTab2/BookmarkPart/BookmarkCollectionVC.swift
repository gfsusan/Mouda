//
//  BookmarkCollectionVC.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 9..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

private let reuseIdentifier = "bookmarkCell"

class BookmarkCollectionVC: UICollectionViewController {

    var bookmarks:[Bookmark] = dataCenter.bookmarks
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        if let destinationNavigationController = segue.destination as? UINavigationController {
////            let targetController = destinationNavigationController.topViewController as? AddPopUpVC
////            targetController?.addDelegate = self
//    }
 

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return bookmarks.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? BookmarkCell
        
        guard let retCell = cell else {
            return cell!
        }
        
        let bookmark = bookmarks[indexPath.row]
        
        // Configure the cell
        retCell.backgroundColor = UIColor.yellow
        
        if let thumbImage = bookmark.book.coverImage {
            retCell.coverImage.image = thumbImage
        } else {
            retCell.coverImage.image = UIImage(named: "book2")
            if let thumbImageURL = bookmark.book.coverImageURL {
                DispatchQueue.main.async(execute: {
                    bookmark.book.coverImage = bookmark.book.getCoverImage(withURL: bookmark.book.coverImageURL!)
                    guard let thumbImage = bookmark.book.coverImage else {
                        return
                    }
                    retCell.coverImage.image = thumbImage
                })
            }
        }
        
        retCell.titleLabel.text = bookmark.book.title
        retCell.pageLabel.text = "\(bookmark.page)"
        
        return retCell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
