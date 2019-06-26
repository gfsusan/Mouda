//
//  AddVC.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 6..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class AddPopUpVC: ViewController, UITabBarControllerDelegate {
    
    var feedDelegate:FeedTableVC?
    
    // 책 선택 화면에서 고른 책
    var book:Book? {
        didSet {
            bookChooseButton.setTitle(book?.title, for: .normal)
        }
    }
    
    lazy var cancelButton: UIBarButtonItem = {
        let b = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonPressed(_:)))
        return b
    }()
    
    lazy var doneButton: UIBarButtonItem = {
        let b = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(doneButtonPressed(_:)))
        return b
    }()
    
    let bookChooseButton: UIButton = {
        let b = UIButton()
        b.setTitle("+ 책 선택", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 15)
        b.backgroundColor = .themeColor
        return b
    }()
    
    let lineTextView: UITextView = {
        let tv = UITextView()
        tv.font = .mySystemFont(ofSize: 14)
        tv.backgroundColor = .clear
        tv.isScrollEnabled = false
        return tv
    }()
    
    let pageTextField: UITextField = {
        let tv = UITextField()
        tv.font = .mySystemFont(ofSize: 17)
        tv.placeholder = "123"
        tv.contentHorizontalAlignment = .center
        
        let l = UILabel(text: "Page", font: .mySystemFont(ofSize: 17), textAlignment: .left, numberOfLines: 1)
        l.sizeToFit()
        l.frame = CGRect(x: 0, y: 0, width: l.frame.width + 8, height: l.frame.height)
        tv.leftViewMode = .always
        tv.leftView = l
        return tv
    }()
    
    let thoughtTextView: UITextView = {
        let tv = UITextView()
        tv.font = .mySystemFont(ofSize: 14)
        tv.backgroundColor = .clear
        tv.isScrollEnabled = false
        return tv
    }()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureTextFieldDelegates()
    }
    
    deinit {
        removeKeyboardObservers()
    }
    
    @IBAction func selectBookPressed(_ sender: Any) {
        let searchVC = SearchTableVC()
        searchVC.addPopUpDelegate = self
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        if let chosenBook = book {
            // line과 page 입력되었는지 확인. thought은 없어도 됨
            if lineTextView.textColor != UIColor.lightGray {
                if pageTextField.textColor != UIColor.lightGray {
                    var text:String
                    if thoughtTextView.textColor == UIColor.lightGray {
                        text = ""
                    } else {
                        text = thoughtTextView.text
                    }
                    let feed = Feed(book: chosenBook, page: Int(pageTextField.text!)!, line: lineTextView.text, thought: text)
                    dataCenter.add(feed: feed)
                    
                    if let tabBarController = self.presentingViewController as? UITabBarController {
                        print("done Button Presend")
                        tabBarController.selectedIndex = 1
                        tabBarController.selectedIndex = 0
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
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func configureConstraints() {
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        
        let lineView = UIView()
        lineView.stack(lineTextView,
                       view.hstack(UIView(), pageTextField, UIView(),
                                   distribution: .equalCentering),
                       spacing: 8).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
        lineView.backgroundColor = .veryLightGray
        pageTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
        
        let thoughtView = UIView()
        thoughtView.stack(thoughtTextView).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
        thoughtView.backgroundColor = .veryLightGray
        
        let contentView = UIView()
        contentView.stack(bookChooseButton.withHeight(60),
                          lineView,
                          thoughtView,
                          spacing: 8)
            .withMargins(.init(top: 8, left: 0, bottom: 0, right: 0))
        
        lineView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
        lineTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        thoughtView.heightAnchor.constraint(greaterThanOrEqualToConstant: 130).isActive = true

        scrollView.addSubview(contentView)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor)
        
        scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    override func addTargets() {
        bookChooseButton.addTarget(self, action: #selector(selectBookPressed(_:)), for: .touchUpInside)
    }
}

extension AddPopUpVC: UITextViewDelegate {
    func configureTextFieldDelegates() {
        setupDelegates()
        addKeyboardObservers()
        configureTapGesture()
        
        lineTextView.text = "간직하고 싶은 책 속의 한 문장을 작성해주세요."
        thoughtTextView.text = "기록한 문장에 대한 본인만의 생각이나 감정을 표현해주세요."
        lineTextView.textColor = UIColor.lightGray
        thoughtTextView.textColor = UIColor.lightGray
    }
    
    func setupDelegates() {
        lineTextView.delegate = self
        thoughtTextView.delegate = self
    }
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }

    /** Hide the keyboard when user touches outside keyboard */
    @objc func handleTap() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        var info = notification.userInfo
        let keyBoardSize = info![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        scrollView.contentInset = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: keyBoardSize.height, right: 0.0)
        scrollView.scrollIndicatorInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: keyBoardSize.height, right: 0.0)
    }
    
    @objc func keyboardDidHide(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    // Placeholder text
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.textColor == UIColor.lightGray) {
            textView.text = nil
            textView.textColor = UIColor.black
            if textView.accessibilityIdentifier == "lineText" {
                // scroll to top
            } else if textView.accessibilityIdentifier == "thoughtText" {
                // scroll to bottom of thought textview
            } 
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
            }
        }
        
        textView.resignFirstResponder()
    }
}
