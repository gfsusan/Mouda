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
    
    var closeFlag = false

    @IBOutlet weak var lineTextView: UITextView!
    @IBOutlet weak var pageTextView: UITextView!
    @IBOutlet weak var thoughtTextView: UITextView!
    @IBAction func selectBookPressed(_ sender: Any) {
    
    }
    @IBAction func doneButtonPressed(_ sender: Any) {
        dataCenter.feeds.append(Feed(book: Book(), page: Int(pageTextView.text)!, line: lineTextView.text, thought: thoughtTextView.text))
        dataCenter.save()
        
        dismiss(animated: true)
//        let sb = UIStoryboard(name: "MyFeed", bundle: nil)
//        let backToMyFeed = sb.instantiateInitialViewController()
        
    }
    
    // Hide keyboard when user touches outside keyboard
    @IBAction func cancelAdd(_ sender: Any) {
        
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
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        let add = segue.destination as? AddVC
        add?.closeFlag = true
    }
 

}
