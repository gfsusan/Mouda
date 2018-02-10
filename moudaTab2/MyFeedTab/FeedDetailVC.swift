//
//  FeedDetailViewController.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 7..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class FeedDetailVC: UIViewController {
    
    var feed:Feed?
    let formatDate = DateFormatter()
    var indexPath:Int?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var thoughtLabel: UILabel!
    
    
    @IBAction func deletePressed(_ sender: Any) {
        let alertView = UIAlertController(title: "삭제", message: "정말로 피드를 삭제하시겠습니까?", preferredStyle: .alert)
        let delete = UIAlertAction(title: "피드 삭제", style: .destructive) { (action) in
            if let index = self.indexPath {
                dataCenter.delete(feedAt: index)
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                dataCenter.createAlert(title: "삭제에 실패했습니다.", message: "다시 시도해 보세요.", sender: self)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .default) {(action) in
        }
        alertView.addAction(cancel)
        alertView.addAction(delete)
        present(alertView, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        formatDate.dateFormat = "yyyy년 MM월 dd일"
        // Do any additional setup after loading the view.
        
        // attribute text style
        let lineStyle = NSMutableParagraphStyle()
        lineStyle.lineSpacing = 5
        lineStyle.alignment = .justified
        let lineAttributes = [NSAttributedStringKey.paragraphStyle: lineStyle]
        
        let thoughtStyle = NSMutableParagraphStyle()
        thoughtStyle.lineSpacing = 5
        thoughtStyle.alignment = .center
        let thoughtAttributes = [NSAttributedStringKey.paragraphStyle: thoughtStyle]
        
        if let myFeed = feed {
            titleLabel.text = myFeed.book.title
            dateLabel.text = "\(formatDate.string(from: myFeed.date))"
            lineLabel.attributedText = NSAttributedString(string: myFeed.line, attributes: lineAttributes)
            pageLabel.text = "Page \(myFeed.page)"
            thoughtLabel.attributedText = NSAttributedString(string: myFeed.thought, attributes: thoughtAttributes)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let destinationNavigationController = segue.destination as? UINavigationController {
            let targetController = destinationNavigationController.topViewController as? ModifyVC
            targetController?.originalFeed = feed
            targetController?.indexPath = self.indexPath
            targetController?.feedDetailDelegate = self
        }
    }
  

}
