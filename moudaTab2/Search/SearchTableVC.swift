//
//  SearchTableVC.swift
//  moudaTab2
//
//  Created by cauadc on 2018. 2. 8..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit

class SearchTableVC: UITableViewController,  UISearchBarDelegate, XMLParserDelegate {
    
    @IBOutlet var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var books:[Book] = []
    var addPopUpDelegate:AddPopUpVC?
    var addBookmarkDelegate:AddBookmarkVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        books = dataCenter.books
        
    }
    // ClientID
    // svT_lXMu_njLXKNKBA2X
    // ClientSecret
    // a_I3ZGoXXY
    
    // https://openapi.naver.com/v1/search/book.xml
    
    // searchBar 검색 버튼 클릭
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        books = []
        if (searchBar.text == "") {
            return
        }
        
        let urlString = "https://openapi.naver.com/v1/search/book.xml?query=" + searchBar.text!
        let urlWithPercentEscapes = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let url = URL(string: urlWithPercentEscapes!)
        
        var request = URLRequest(url: url!)
        request.addValue("application/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("svT_lXMu_njLXKNKBA2X", forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue("a_I3ZGoXXY", forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print(error)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            // 수신한 데이터 출력
            print(String(data: data, encoding: String.Encoding.utf8))
            
            self.item?.title = ""
            self.item?.coverImageURL = ""
            self.item?.publisher = ""
            self.item?.writer = ""
            
            // Parse the XML
            let parser = XMLParser(data: Data(data))
            parser.delegate = self
            let success:Bool = parser.parse()
            if success {
                print("parse success!")
                print(self.strXMLData)
            } else {
                print("parse failure!")
            }
        }
        
        task.resume()
        
    }
    
    // XML delegate
    var currentElement : String? = ""
    var strXMLData : String? = ""
    var item:Book? = nil
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "title" || elementName == "image" || elementName == "publisher" || elementName == "author" {
            flag = true
            temp=""
            if elementName == "title" {
                item = Book()
            }
        }
    }
    
    var flag:Bool = false
    var temp:String = ""
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "title" {
            item?.title = temp.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            print("title: \(temp)")
        } else if elementName == "image" {
            item?.coverImageURL = temp
        } else if elementName == "publisher" {
            item?.publisher = temp.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        } else if elementName == "author" {
            item?.writer = temp.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            books.append(self.item!)
            table.reloadData()
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        temp += string
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookInfoCell", for: indexPath) as! SearchBookCell

        
        let book = books[indexPath.row]
        // Configure the cell...
        
        if let thumbImage = book.coverImage {
            cell.bookImageView.image = thumbImage
        } else {
            cell.bookImageView.image = UIImage(named: "book2")
            if let thumbImageURL = book.coverImageURL {
                DispatchQueue.main.async(execute: {
                    book.coverImage = book.getCoverImage(withURL: book.coverImageURL!)
                    guard let thumbImage = book.coverImage else {
                        return
                    }
                    cell.bookImageView.image = thumbImage
                })
            }
            
            
        }
        cell.titleTV.text = book.title
        cell.writerTV.text = book.writer
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.addPopUpDelegate?.book = books[indexPath.row]
        self.addBookmarkDelegate?.book = books[indexPath.row]
        self.addBookmarkDelegate?.addBookmarkButton.setTitle("다시 선택", for: .normal)
        navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
//        if let destinationNavigationController = segue.destination as? UINavigationController {
//            let targetController = destinationNavigationController.topViewController as? AddPopUpVC
//            targetController?.addDelegate = self
    }
   

}
