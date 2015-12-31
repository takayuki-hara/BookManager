//
//  BookSearcherTableViewCell.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/24.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit
import Cosmos

class BookSearcherTableViewCell: UITableViewCell {

	// MARK: - @IBOutlet
	@IBOutlet weak var bookImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var publisherLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var cosmosView: CosmosView!
	@IBOutlet weak var reviewLabel: UILabel!

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
	func updateCell(book: BookObject) {
		let url = NSURL(string: book.imageUrl)
		bookImageView.hnk_setImageFromURL(url!)
		
		titleLabel.text = book.title
		authorLabel.text = book.author
		publisherLabel.text = book.publisher
		dateLabel.text = book.salesDate
		priceLabel.text = "¥ " + String(book.price)
		
		cosmosView.rating = Double(book.reviewAverage)!
		cosmosView.settings.updateOnTouch = false
		reviewLabel.text = " (" + String(book.reviewCount) + ")"
	}
}
