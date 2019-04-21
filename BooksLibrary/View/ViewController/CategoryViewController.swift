//
//  ViewController.swift
//  BooksLibrary
//
//  Created by Akhila Haridas on 20/04/19.
//  Copyright © 2019 Akhila Haridas. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    @IBOutlet weak var categoryTableView: UITableView?
    var bookArray = [Book]()
    var categoryArray = [String]()
    var dicArray = [Dictionary<String, String>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Common.getDataState())
        if !Common.getDataState() {
            parseJson()
        }
        self.getCategories()
    }

    func parseJson() {
        JsonUtility.parseJsonFromFile(fileName: "sample") { (error, responseData) in
            if error == nil {
                let json = try? JSONDecoder().decode([Book].self, from: responseData!)
                self.bookArray = json!
                DBManager.sharedInstance.saveBookObjects(books: self.bookArray)
                Common.setDataState(isSaved: true)
            }
        }
    }
    
    func getCategories() {
        if let authors = DBManager.sharedInstance.getCategories(by: "authorName") {
            dicArray.append(contentsOf: authors)
            for item in authors {
                categoryArray.append(contentsOf: item.values)
            }
        }
        if let genres = DBManager.sharedInstance.getCategories(by: "genre") {
            dicArray.append(contentsOf: genres)
            for item in genres {
                categoryArray.append(contentsOf: item.values)
            }
        }
        if let countries = DBManager.sharedInstance.getCategories(by: "authorCountry") {
            dicArray.append(contentsOf: countries)
            for item in countries {
                categoryArray.append(contentsOf: item.values)
            }
        }
        DispatchQueue.main.async {
            self.categoryTableView?.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBookList" {
            let listVC = segue.destination as! BookListViewController
            listVC.selectedItem = (sender as? Dictionary<String, String>)!
        }
    }
    
}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let categoryCell = tableView.dequeueReusableCell(withIdentifier: kBookCategoryCellID) as? BookCategoryTableViewCell {
            let category = categoryArray[indexPath.row]
            categoryCell.categoryText = category
            return categoryCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = dicArray[indexPath.row]
        self.performSegue(withIdentifier: "showBookList", sender: selectedItem)
    }
}
