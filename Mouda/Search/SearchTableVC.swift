//
//  SearchTableVC.swift
//  Mouda
//
//  Created by cauadc on 2018. 2. 8..
//  Copyright © 2018년 cauadc. All rights reserved.
//

import UIKit
import LBTATools

private let cellId = "bookInfoCellId"

class SearchTableVC: UITableViewController, UISearchResultsUpdating, XMLParserDelegate {

    var searchResult: [Book] = []
    var addPopUpDelegate: AddFeedVC?
    var addBookmarkDelegate: AddBookmarkVC?
    
    lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.barStyle = .blackTranslucent
        sc.searchBar.tintColor = .white
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "검색"

        tableView.register(SearchBookCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3) {
            self.navigationItem.hidesSearchBarWhenScrolling = false
        }
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func configureSearchBar() {
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
    }
    
    // ClientID
    // svT_lXMu_njLXKNKBA2X
    // ClientSecret
    // a_I3ZGoXXY
    
    // https://openapi.naver.com/v1/search/book.xml
    
    // MARK: - XML delegate
    var currentElement : String? = ""
    var strXMLData : String? = ""
    var item: Book? = nil
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "title" || elementName == "image" || elementName == "publisher" || elementName == "author" {
            flag = true
            temp = ""
            if elementName == "title" {
                item = Book()
            }
        }
    }
    
    var flag: Bool = false
    var temp: String = ""
    
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
            searchResult.append(self.item!)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        temp += string
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let errCell = UITableViewCell()
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SearchBookCell else { return errCell }
        guard indexPath.row < searchResult.count else { return cell }
        
        let book = searchResult[indexPath.row]
        
        if let thumbImageURL = book.coverImageURL {
            cell.bookImageView.loadImageUsingUrlString(imageUrl: thumbImageURL)
        }
        cell.titleTV.text = book.title
        cell.writerTV.text = book.writer
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.addPopUpDelegate?.book = searchResult[indexPath.row]
        
        self.addBookmarkDelegate?.book = searchResult[indexPath.row]

        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        guard searchText != "" else { return }
        
        searchResult = []
        
        let urlString = "https://openapi.naver.com/v1/search/book.xml?query=" + searchText
        guard let urlWithPercentEscapes = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else { return }
        guard let url = URL(string: urlWithPercentEscapes) else { return }
        
        var request = URLRequest(url: url)
        request.addValue("application/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("svT_lXMu_njLXKNKBA2X", forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue("a_I3ZGoXXY", forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print(error as Any)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            // 수신한 데이터 출력
            print(String(data: data, encoding: String.Encoding.utf8) as Any)
            
            self.item?.title = ""
            self.item?.coverImageURL = ""
            self.item?.publisher = ""
            self.item?.writer = ""
            
            // Parse the XML
            let parser = XMLParser(data: Data(data))
            parser.delegate = self
            let success:Bool = parser.parse()
            if success {
                debugPrint("parse success!")
                debugPrint(self.strXMLData as Any)
            } else {
                debugPrint("parse failure!")
            }
        }
        
        task.resume()
    }
}
