//
//  AddBookmarkViewController.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 7..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class AddBookmarkVC: UIViewController {
    
    var delegate:BookmarkCollectionVC?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    
    @IBOutlet weak var addBookmarkButton: UIButton!
    @IBAction func chooseButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = ""
        publisherLabel.text = ""
        authorLabel.text = ""
        // Do any additional setup after loading the view.
    }
    @IBAction func cancelBookmark(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func saveBookmark(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
