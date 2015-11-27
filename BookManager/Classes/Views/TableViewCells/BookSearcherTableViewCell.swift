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

	@IBOutlet weak var bookImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var cosmosView: CosmosView!
	@IBOutlet weak var reviewLabel: UILabel!

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
//	override func layoutSubviews() {
//		super.layoutSubviews()
//		self.imageView?.frame = CGRectMake(8, 8, 68, 100)
//	}
}
