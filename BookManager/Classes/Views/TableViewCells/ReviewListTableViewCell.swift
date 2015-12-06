//
//  ReviewListTableViewCell.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/12/06.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit
import Cosmos

class ReviewListTableViewCell: UITableViewCell {

	// MARK: - @IBOutlet
	@IBOutlet weak var bookImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var reviewerLabel: UILabel!
	@IBOutlet weak var cosmosView: CosmosView!
	@IBOutlet weak var detailLabel: UILabel!

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
	func setBookInfo(review: ReviewDataModel) {
		let url = NSURL(string: review.book.imageUrl!)
		bookImageView.hnk_setImageFromURL(url!)
		
		titleLabel.text = review.book.title
		reviewerLabel.text = "レビュー者：" + review.reviewer

		cosmosView.rating = review.rate
		cosmosView.settings.updateOnTouch = false

		detailLabel.text = review.detail
	}
}
