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

    @IBOutlet weak var lineTextView: UITextView!
    @IBOutlet weak var pageTextView: UITextView!
    @IBOutlet weak var thoughtTextView: UITextView!
    @IBAction func selectBookPressed(_ sender: Any) {
    
    }
    @IBAction func doneButtonPressed(_ sender: Any) {
        dataCenter.feeds.insert(Feed(book: Book(), page: Int(pageTextView.text)!, line: lineTextView.text, thought: thoughtTextView.text), at: 0)
        dataCenter.save()
        
//        if let feedTableVC = feedDelegate {
//            print("reloadData")
//            feedTableVC.tableView.reloadData()
//        }
        
        // 저장 작업 외에는 Cancel과 똑같이 modal dismiss만 해주면 됨
        cancelAdd(sender)
        
    }
    
    // Hide keyboard when user touches outside keyboard
    @IBAction func cancelAdd(_ sender: Any) {
        print("done Button Pressed")
        //delegate로 closeFlag값 true로 설정
        if let addVC = addDelegate {
            print("add view controller delegate 성공")
            addVC.closeFlag = true
        }
        dismiss(animated: true)
        //        let sb = UIStoryboard(name: "MyFeed", bundle: nil)
        //        let backToMyFeed = sb.instantiateInitialViewController()
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

}
