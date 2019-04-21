//
//  BookCategoryTableViewCell.swift
//  BooksLibrary
//
//  Created by Akhila Haridas on 20/04/19.
//  Copyright © 2019 Akhila Haridas. All rights reserved.
//

import UIKit

class BookCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCategory: UILabel?
    
    var categoryText: String? {
        didSet {
            DispatchQueue.main.async {
                self.lblCategory?.text = self.categoryText?.capitalized
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        lblCategory?.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
