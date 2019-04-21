//
//  BookTableViewCell.swift
//  BooksLibrary
//
//  Created by Akhila Haridas on 21/04/19.
//  Copyright © 2019 Akhila Haridas. All rights reserved.
//

import UIKit
import SDWebImage

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookImageView: UIImageView?
    @IBOutlet weak var lblBookName: UILabel?
    @IBOutlet weak var lblAuthor: UILabel?
    @IBOutlet weak var lblGenre: UILabel?
    
    var book: BookDM? {
        didSet {
            DispatchQueue.main.async {
                self.bookImageView?.sd_setImage(with: URL(string: self.book?.imageUrl ?? ""), placeholderImage: UIImage(named: "placeholder"))
                self.lblBookName?.text = self.book?.bookTitle
                self.lblAuthor?.text = self.book?.authorName
                self.lblGenre?.text = self.book?.genre
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
