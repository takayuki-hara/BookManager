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
	@IBOutlet weak var publisherLabel: UILabel!
	@IBOutlet weak var isbnLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
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
		// 画像の色に合わせて背景やテキストを調整する
		//bookImageView.hnk_setImageFromURL(url!, placeholder: nil, format: nil, failure: nil) { image in
		//	self.bookImageView.image = image
		//	let colors = image.getColors()
		//	self.backgroundColor = colors.backgroundColor
		//	self.titleLabel.textColor = colors.primaryColor
		//	self.authorLabel.textColor = colors.secondaryColor
		//	self.publisherLabel.textColor = colors.detailColor
		//	self.isbnLabel.textColor = colors.detailColor
		//	self.dateLabel.textColor = colors.detailColor
		//	self.priceLabel.textColor = colors.detailColor
		//	self.textView.textColor = colors.detailColor
		//}
		
		titleLabel.text = book.title
		authorLabel.text = book.author
		publisherLabel.text = book.publisher
		isbnLabel.text = book.isbn
		dateLabel.text = book.salesDate
		priceLabel.text = "¥ " + String(book.price!)
		
		if let rating = book.reviewAverage {
			cosmosView.rating = Double(rating)!
			cosmosView.settings.updateOnTouch = false
		}
		reviewLabel.text = "(" + String(book.reviewCount!) + ")"
		
		textView.text = book.itemCaption
	}

}
