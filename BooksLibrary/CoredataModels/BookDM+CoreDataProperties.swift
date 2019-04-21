//
//  BookDM+CoreDataProperties.swift
//  BooksLibrary
//
//  Created by Akhila Haridas on 20/04/19.
//  Copyright © 2019 Akhila Haridas. All rights reserved.
//
//

import Foundation
import CoreData
import Fuse



extension BookDM {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<BookDM> {
        return NSFetchRequest<BookDM>(entityName: "BookDM")
    }

    @NSManaged public var id: String?
    @NSManaged public var genre: String?
    @NSManaged public var publisher: String?
    @NSManaged public var bookTitle: String?
    @NSManaged public var authorName: String?
    @NSManaged public var authorCountry: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var soldCount: Int16
    
   public var properties: [FuseProperty] {
        return [
            FuseProperty(name: "authorName", weight: 0.6),
            FuseProperty(name: "bookTitle", weight: 0.8),
            FuseProperty(name: "authorCountry", weight: 0.4),
        ]
    }

}
