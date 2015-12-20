//
//  ReviewViewController.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/12/06.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit
import Cosmos
import SCLAlertView

class ReviewViewController: UIViewController {

	// MARK: - @IBOutlet
	@IBOutlet weak var bookImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var cosmosView: CosmosView!
	@IBOutlet weak var textView: UITextView!

	// MARK: - @IBOutlet
	@IBAction func didPushReviewButton(sender: AnyObject) {
		if ReviewAccess.addReview(library.book, rate: cosmosView.rating, detail: textView.text) == false {
			let alertView = SCLAlertView()
			alertView.addButton("更新") {
				log.debug("pushed OK!")
				ReviewAccess.addReview(self.library.book, rate: self.cosmosView.rating, detail: self.textView.text, update: true)
			}
			alertView.addButton("CANCEL") {
				log.debug("Pushed CANCEL!")
				return
			}
			alertView.showWarning("確認", subTitle: "レビュー済みの書籍です。更新しますか？")
		} else {
			SCLAlertView().showSuccess("レビュー", subTitle: "レビューを投稿しました")
		}
		ReviewAccess.consoleOutReviews()
	}

	// MARK: - Property
	var library: BookLibraryDataModel!

	// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

		// 書籍情報の表示
        displayBookInfo()

		// キーボード外のタッチでキーボードを閉じるための設定
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: "closeSoftKeyboard")
		self.view.addGestureRecognizer(gestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Private Methods
	private func displayBookInfo() {
		let url = NSURL(string: library.book.imageUrl!)
		bookImageView.hnk_setImageFromURL(url!)

		titleLabel.text = library.book.title
		authorLabel.text = library.book.author
		textView.layer.borderWidth = 1
		textView.layer.borderColor = UIColor.blackColor().CGColor
	}

	func closeSoftKeyboard() {
		self.view.endEditing(true)
	}
}
