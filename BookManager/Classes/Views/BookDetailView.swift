//
//  BookDetailView.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/12/06.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit
import Cosmos

class BookDetailView: UIView {

	// MARK: - @IBOutlet
	@IBOutlet weak var bookImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var isbnLabel: UILabel!
	@IBOutlet weak var publisherLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var cosmosView: CosmosView!
	@IBOutlet weak var reviewLabel: UILabel!
	@IBOutlet weak var textView: UITextView!

	// MARK: - Lifecycle
	override func awakeFromNib() {
		// XIB読み込み
		let view = NSBundle.mainBundle().loadNibNamed("BookDetailView", owner: self, options: nil).first as! UIView
		addSubview(view)
	}
	
	// MARK: - Public Method
	func setBookInfo(book: BookDataModel) {
		let url = NSURL(string: book.imageUrl!)
		bookImageView.hnk_setImageFromURL(url!)
		
		titleLabel.text = book.title
		authorLabel.text = book.author
		isbnLabel.text = book.isbn
		publisherLabel.text = book.publisher
		priceLabel.text = String(book.price!) + " 円"
		dateLabel.text = book.salesDate
		
		if let rating = book.reviewAverage {
			cosmosView.rating = Double(rating)!
			cosmosView.settings.updateOnTouch = false
		}
		reviewLabel.text = String(book.reviewCount!) + " 件"
		
		textView.text = book.itemCaption
	}

}
