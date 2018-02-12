//
//  ModifyVC.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 10..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class ModifyVC: UIViewController, UITextViewDelegate{

    var originalFeed:Feed?
    var indexPath:Int?
    var feedDetailDelegate:FeedDetailVC?
    
    // 책 선택 화면에서 고른 책
    var book:Book?
    
    @IBOutlet weak var bookChooseButton: UIButton!
    @IBOutlet weak var lineTextView: UITextView!
    @IBOutlet weak var pageTextView: UITextView!
    @IBOutlet weak var thoughtTextView: UITextView!
    @IBAction func selectBookPressed(_ sender: Any) {
        
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        if let chosenBook = book {
            // line과 page 입력되었는지 확인. thought은 없어도 됨
            if lineTextView.textColor != UIColor.lightGray {
                if pageTextView.textColor != UIColor.lightGray {
                    var text:String
                    if thoughtTextView.textColor == UIColor.lightGray {
                        text = ""
                    } else {
                        text = thoughtTextView.text
                    }
                    // 새로운 피드 생성
                    let feed:Feed
                    guard let original = originalFeed else {
                        feed = Feed(book: chosenBook, page: Int(pageTextView.text)!, line: lineTextView.text, thought: text)
                        dataCenter.createAlert(title: "삭제에 실패하였습니다.", message: "다시 시도해주세요.", sender: self)
                        return
                    }
                    
                    feed = Feed(book: chosenBook, page: Int(pageTextView.text)!, line: lineTextView.text, thought: text, date: original.date)
                   
                    
                    //델리게이트 업데이트
                    feedDetailDelegate?.titleLabel.text = feed.book.title
                    feedDetailDelegate?.lineLabel.text = feed.line
                    feedDetailDelegate?.pageLabel.text = "Page \(feed.page)"
                    feedDetailDelegate?.thoughtLabel.text = feed.thought
                    
                    
                    //데이터 센터 업데이트
                    if let index = indexPath {
                        dataCenter.delete(feed: original, at: index, sender: self)
                        dataCenter.add(feed: feed)
                    }
                    
                    
                    // 저장 작업 외에는 Cancel과 똑같이 modal dismiss만 해주면 됨
                    cancelButtonPressed(sender)
                    
                } else { // page 입력 안됨
                    dataCenter.createAlert(title: "알림", message: "페이지를 입력해주세요.", sender: self)
                    return
                }
            } else { // line 입력 안됨
                dataCenter.createAlert(title: "알림", message: "마음에 드는 문장을 입력해주세요.", sender: self)
                return
            }
        } else { // 책 선택 안됨
            dataCenter.createAlert(title: "알림", message: "책을 선택해주세요.", sender: self)
            return
        }
    }
    
    
    // Hide keyboard when user touches outside keyboard
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func tabGesture(_ sender: Any) {
        self.view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lineTextView.delegate = self
        self.pageTextView.delegate = self
        self.thoughtTextView.delegate = self
        
        
        guard let feed = originalFeed else {
            lineTextView.textColor = UIColor.lightGray
            pageTextView.textColor = UIColor.lightGray
            thoughtTextView.textColor = UIColor.lightGray
            lineTextView.text = "간직하고 싶은 책 속의 한 문장을 작성해주세요."
            pageTextView.text = "123"
            thoughtTextView.text = "기록한 문장에 대한 본인만의 생각이나 감정을 표현해주세요."
            return
        }
        book = feed.book
        lineTextView.textColor = UIColor.black
        pageTextView.textColor = UIColor.black
        if thoughtTextView.text == "" {
            thoughtTextView.text = "기록한 문장에 대한 본인만의 생각이나 감정을 표현해주세요."
            thoughtTextView.textColor = UIColor.lightGray
        } else {
            thoughtTextView.textColor = UIColor.black
            thoughtTextView.text = feed.thought
        }
        lineTextView.text = feed.line
        pageTextView.text = "\(feed.page)"
        bookChooseButton.setTitle(feed.book.title, for: .normal)
      
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("add popup view will appear")
        if let chosenBook = book {
            print("book chosen")
            bookChooseButton.setTitle(chosenBook.title, for: .normal)
        }
    }
    
    
    // Placeholder text
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.textColor == UIColor.lightGray) {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            textView.textColor = UIColor.lightGray
            if textView.accessibilityIdentifier == "lineText" {
                textView.text = "간직하고 싶은 책 속의 한 문장을 작성해주세요."
            } else if textView.accessibilityIdentifier == "thoughtText" {
                textView.text = "기록한 문장에 대한 본인만의 생각이나 감정을 표현해주세요."
            } else if textView.accessibilityIdentifier == "pageText" {
                textView.text = "123"
            }
        }
        textView.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationNavigationController = segue.destination as? SearchTableVC {
            destinationNavigationController.modifyDelegate = self
        }
    }
 

}
