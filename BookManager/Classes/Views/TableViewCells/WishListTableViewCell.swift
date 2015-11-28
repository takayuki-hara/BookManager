//
//  WishListTableViewCell.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/28.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit
import Cosmos

class WishListTableViewCell: UITableViewCell {

	// MARK: - @IBOutlet
	@IBOutlet weak var bookImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var authorLabel: UILabel!
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
    
}
