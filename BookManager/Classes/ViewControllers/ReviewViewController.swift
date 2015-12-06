//
//  ReviewViewController.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/12/06.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit
import Cosmos

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
			// アラート表示
			let alertController = UIAlertController(title: "登録エラー", message: "レビュー済みの書籍です", preferredStyle: .Alert)
			let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
			alertController.addAction(defaultAction)
			presentViewController(alertController, animated: true, completion: nil)
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
