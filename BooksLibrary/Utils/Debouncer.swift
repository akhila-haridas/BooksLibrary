//
//  Debouncer.swift
//  BooksLibrary
//
//  Created by Akhila Haridas on 21/04/19.
//  Copyright © 2019 Akhila Haridas. All rights reserved.
//

import UIKit

class Debouncer {
    
    private let queue = DispatchQueue.main
    private var workItem = DispatchWorkItem(block: {})
    private var interval: TimeInterval
    
    init(seconds: TimeInterval) {
        self.interval = seconds
    }
    
    // MARK: - Debouncing function
    func debounce(action: @escaping (() -> Void)) {
        workItem.cancel()
        workItem = DispatchWorkItem(block: { action() })
        queue.asyncAfter(deadline: .now() + interval, execute: workItem)
    }
}
