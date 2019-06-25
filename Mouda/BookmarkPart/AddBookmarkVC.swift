//
//  AddBookmarkViewController.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 7..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class AddBookmarkVC: UIViewController {
    
    var delegate:BookmarkCollectionVC?
    
    var book:Book?
    var page:Int?

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var PageTextField: UITextField!
    
    @IBOutlet weak var addBookmarkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = ""
        publisherLabel.text = ""
        authorLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bookImageView.image = book?.coverImage
        titleLabel.text = book?.title
        publisherLabel.text = book?.publisher
        authorLabel.text = book?.writer
    }
    
    @IBAction func cancelBookmark(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveBookmark(_ sender: Any) {
        if let selectedBook = book {
            if let pageText = PageTextField.text {
                if let page = Int(pageText) {
                    if dataCenter.hasBookmark(of: selectedBook) == false{
                        dataCenter.add(bookmark: Bookmark(book: selectedBook, page: page))
                        self.dismiss(animated: true, completion: nil)
                    }
                    else {
                        dataCenter.createAlert(title: "이미 북마크가 있어요!", message: "", sender:self)
                        return
                    }
                } else {
                    dataCenter.createAlert(title: "페이지를 입력해주세요.", message: "", sender:self)
                    return
                }
            }

        } else {
            dataCenter.createAlert(title: "책을 선택하지 않으셨네요.", message: "책 선택 버튼을 눌러 책을 선택해주세요!", sender: self)
            return
        }
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationNavigationController = segue.destination as? SearchTableVC {
            destinationNavigationController.addBookmarkDelegate = self
        }
    }
 

}
