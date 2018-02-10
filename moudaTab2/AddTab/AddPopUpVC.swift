//
//  AddVC.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 6..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class AddPopUpVC: UIViewController, UITextViewDelegate, UITabBarControllerDelegate {
    
    var delegate:DataCenter?
    var addDelegate:AddVC?
    var feedDelegate:FeedTableVC?
    
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
                    let feed = Feed(book: chosenBook, page: Int(pageTextView.text)!, line: lineTextView.text, thought: thoughtTextView.text)
                    dataCenter.add(feed: feed)
            
            // 저장 작업 외에는 Cancel과 똑같이 modal dismiss만 해주면 됨
                cancelButtonPressed(sender)
                    
                } else { // page 입력 안됨
                    return
                }
            } else { // line 입력 안됨
                return
            }
        } else { // 책 선택 안됨
            // TODO 책을 선택하라는 notification
            return
        }
    }
    
    
    // Hide keyboard when user touches outside keyboard
    @IBAction func cancelButtonPressed(_ sender: Any) {
        print("done Button Pressed")
        //delegate로 closeFlag값 true로 설정
        if let addVC = addDelegate {
            print("add view controller delegate 성공")
            addVC.closeFlag = true
        }
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
        lineTextView.text = "간직하고 싶은 책 속의 한 문장을 작성해주세요."
        pageTextView.text = "123"
        thoughtTextView.text = "기록한 문장에 대한 본인만의 생각이나 감정을 표현해주세요."
        lineTextView.textColor = UIColor.lightGray
        pageTextView.textColor = UIColor.lightGray
        thoughtTextView.textColor = UIColor.lightGray
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if let destinationNavigationController = segue.destination as? SearchTableVC {
            destinationNavigationController.addPopUpDelegate = self
        }
    }

}
