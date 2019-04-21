//
//  DBManager.swift
//  BooksLibrary
//
//  Created by Akhila Haridas on 20/04/19.
//  Copyright © 2019 Akhila Haridas. All rights reserved.
//

import UIKit
import CoreData

class DBManager {
    
    static let sharedInstance = DBManager()
    
    private init() {
        
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveBookObjects(books: [Book]) {
        let context = appDelegate.persistentContainer.viewContext
        for book in books {
            let entity = NSEntityDescription.insertNewObject(forEntityName: kBooksEntity, into: context) as! BookDM
            entity.id = book.id
            entity.bookTitle = book.bookTitle
            entity.genre = book.genre
            entity.publisher = book.publisher
            entity.authorName = book.authorName
            entity.authorCountry = book.authorCountry
            entity.imageUrl = book.imageUrl
            entity.soldCount = Int16(book.soldCount)
            do {
                try context.save()
            } catch {
                print("couldn't save book")
            }
        }
    }
    
    func getCategories(by attribute: String)-> [Dictionary<String,String>]? {
        let context = appDelegate.persistentContainer.viewContext
        let countryRequest = NSFetchRequest<NSFetchRequestResult>(entityName: kBooksEntity)
        countryRequest.resultType = .dictionaryResultType
        countryRequest.returnsDistinctResults = true
        countryRequest.returnsObjectsAsFaults = false
        countryRequest.propertiesToFetch = [attribute]//,"authorName","genre"]
        var countryArray = [String]()
        do {
            let dic = try context.fetch(countryRequest) as! [Dictionary<String,String>]
            print(dic)
            for item in dic {
                print(item.values)
                countryArray.append(contentsOf: item.values)
            }
            return dic
        } catch {
            print(error)
            return nil
        }
    }
    
   
    
    func getBookList(by key: String, value: String)-> [BookDM]? {
        let context = appDelegate.persistentContainer.viewContext
        let countryRequest = NSFetchRequest<NSFetchRequestResult>(entityName: kBooksEntity)
        let predicate = NSPredicate(format: "\(key) == %@", value)
        countryRequest.predicate = predicate
        countryRequest.resultType = .managedObjectResultType
        countryRequest.returnsObjectsAsFaults = false
        do {
            let books = try context.fetch(countryRequest) as! [BookDM]
            print(books)
            return books
        } catch {
            print(error)
            return nil
        }
    }
    
}
