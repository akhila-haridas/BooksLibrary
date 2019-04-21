//
//  Common.swift
//  BooksLibrary
//
//  Created by Akhila Haridas on 20/04/19.
//  Copyright © 2019 Akhila Haridas. All rights reserved.
//

import Foundation

class Common {
    
    static func setDataState(isSaved: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(isSaved, forKey: kDataSaved)
        userDefaults.synchronize()
    }
    
    static func getDataState() -> Bool {
        let userDefaults = UserDefaults.standard
        let isSaved = userDefaults.bool(forKey: kDataSaved)
        return isSaved
    }
}
