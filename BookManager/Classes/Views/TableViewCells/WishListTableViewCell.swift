//
//  WishListTableViewCell.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/28.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit

class WishListTableViewCell: UITableViewCell {

	// MARK: - @IBOutlet
	@IBOutlet weak var bookImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var addDateLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var wisherLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!

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
	func updateCell(wish: WishListObject) {
		guard let book = wish.book else {
			return
		}
		let url = NSURL(string: book.imageUrl)
		bookImageView.hnk_setImageFromURL(url!)
		
		titleLabel.text = book.title
		authorLabel.text = book.author
		addDateLabel.text = "追加日：" + wish.addDate
		dateLabel.text = "発売日：" + book.salesDate
		wisherLabel.text = "登録者：" + wish.wisher
		priceLabel.text = "¥ " + String(book.price)
	}
}
