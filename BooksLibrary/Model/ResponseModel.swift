//
//  ResponseModel.swift
//  BooksLibrary
//
//  Created by Akhila Haridas on 20/04/19.
//  Copyright © 2019 Akhila Haridas. All rights reserved.
//

import Foundation

struct Book: Codable {
    let id, bookTitle, authorName, genre, publisher, authorCountry, imageUrl: String
    let soldCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id, genre, publisher
        case bookTitle = "book_title"
        case authorName = "author_name"
        case authorCountry = "author_country"
        case imageUrl = "image_url"
        case soldCount = "sold_count"
    }
}
