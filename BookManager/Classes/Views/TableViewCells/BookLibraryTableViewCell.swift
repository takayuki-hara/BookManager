//
//  BookLibraryTableViewCell.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/12/01.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit
import Cosmos

class BookLibraryTableViewCell: UITableViewCell {

	// MARK: - @IBOutlet
	@IBOutlet weak var bookImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var rentabableLabel: UILabel!
	@IBOutlet weak var ownerLabel: UILabel!
	@IBOutlet weak var isRentedLabel: UILabel!

	
	// MARK: - Lifecycle
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	// MARK: - Action
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
	// MARK: - Public Method
	func setBookInfo(library: BookLibraryDataModel) {
		let url = NSURL(string: library.book.imageUrl!)
		bookImageView.hnk_setImageFromURL(url!)
		
		titleLabel.text = library.book.title
		authorLabel.text = library.book.author
		dateLabel.text = "登録日：" + library.addDate
		ownerLabel.text = "所有者：" + library.owner
		if library.rentalable {
			rentabableLabel.text = "Rental：○"
			if library.isRented {
				isRentedLabel.text = "貸出中"
				isRentedLabel.textColor = UIColor.redColor()
			} else {
				isRentedLabel.text = "貸出可能"
				isRentedLabel.textColor = UIColor.blueColor()
			}
		} else {
			rentabableLabel.text = "Rental：×"
			isRentedLabel.text = "---"
		}
	}
}
