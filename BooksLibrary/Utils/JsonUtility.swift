//
//  JsonUtility.swift
//  BooksLibrary
//
//  Created by Akhila Haridas on 20/04/19.
//  Copyright © 2019 Akhila Haridas. All rights reserved.
//

import UIKit

class JsonUtility {
    
    static func parseJsonFromFile(fileName: String, onCompletion: @escaping (NSError?,Data?)-> Void) -> Void {
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Unable to locate file")
            return
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            onCompletion(nil, data)
        } catch {
            print(error)
            onCompletion(error as NSError, nil)
        }
    }
}
