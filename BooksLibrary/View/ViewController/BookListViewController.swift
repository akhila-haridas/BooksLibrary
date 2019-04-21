//
//  BookListViewController.swift
//  BooksLibrary
//
//  Created by Akhila Haridas on 21/04/19.
//  Copyright © 2019 Akhila Haridas. All rights reserved.
//

import UIKit
import CoreData
import Fuse

class BookListViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var listTableView: UITableView?
    
    var selectedItem = Dictionary<String, String>()
    var bookArray = [BookDM]()
    var filteredBooks = [BookDM]()
    let debouncer = Debouncer(seconds: 0.6)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let fuse = Fuse()
    var isSearching: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar?.delegate = self
        listTableView?.keyboardDismissMode = .onDrag
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookArray = DBManager.sharedInstance.getBookList(by: (selectedItem.keys.first)!, value: selectedItem.values.first!)!
        reloadTableView()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.listTableView?.reloadData()
        }
    }

    func searchItem(query: String){
        filteredBooks.removeAll()
        isSearching = true
        let fuse = Fuse()
        
        let results = fuse.search(query, in: bookArray)
       
        results.forEach { (arg0) in
            let (index, _, _) = arg0
            filteredBooks.append(bookArray[index])
        }
        reloadTableView()
    }
}

extension BookListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredBooks.count
        }
        return bookArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let bookCell = tableView.dequeueReusableCell(withIdentifier: "bookViewCell", for: indexPath) as? BookTableViewCell {
            var book = BookDM()
            if isSearching {
                book = filteredBooks[indexPath.row]
            } else {
                book = bookArray[indexPath.row]
            }
            bookCell.book = book
            return bookCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension BookListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            debouncer.debounce {
                self.searchItem(query: searchText)
            }
        } else {
            isSearching = false
            DispatchQueue.main.async {
                self.listTableView?.reloadData()
            }
        }
    }
    
}
