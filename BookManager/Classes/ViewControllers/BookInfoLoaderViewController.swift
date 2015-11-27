//
//  BookInfoLoaderViewController.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/23.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit
import Cosmos
import Haneke

class BookInfoLoaderViewController: UIViewController {

	@IBOutlet weak var isbnTextField: UITextField!
	@IBOutlet weak var bookImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var cosmosView: CosmosView!
	@IBOutlet weak var reviewLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var textView: UITextView!

	@IBAction func didPushIsbnSearchButton(sender: AnyObject) {
		//TODO:入力チェック
		self.loadBookData(isbnTextField.text!)
	}

	@IBAction func didPushCameraSearchButton(sender: AnyObject) {
		if reader == nil {
			reader = IsbnReaderView(frame: (self.view?.frame)!)
		}
		self.view.addSubview(reader!)
		let result = reader?.capture{ isbn in
			self.loadBookData(isbn)
			self.reader?.removeFromSuperview()
		}
		// 失敗したら固定データで処理を行う（テスト用）
		if result == false {
			// TODO:alart
			loadBookData("9784800710703")
		}
	}

	var book: BookDataModel?
	var reader: IsbnReaderView?

	override func viewDidLoad() {
        super.viewDidLoad()

		// キーボード外のタッチでキーボードを閉じるための設定
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: "closeSoftKeyboard")
		self.view.addGestureRecognizer(gestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

	// MARK: - Private Methods
	func closeSoftKeyboard() {
		self.view.endEditing(true)
	}

	private func displayBookInfo(book: BookDataModel) {
		let url = NSURL(string: book.largeImageUrl!)
		bookImageView.hnk_setImageFromURL(url!)

		titleLabel.text = book.title
		authorLabel.text = book.author

		if let rating = book.reviewAverage {
			cosmosView.rating = Double(rating)!
			cosmosView.settings.updateOnTouch = false
		}
		reviewLabel.text = String(book.reviewCount!) + " 件"

		priceLabel.text = String(book.itemPrice!) + " 円"
		dateLabel.text = book.salesDate
		textView.text = book.itemCaption
	}

	private func loadBookData(isbn: String) {
		let logic = BookInfoLoaderViewLogic()
		logic.loadBookDataWithIsbn(isbn) { result in
			if let book = result {
				self.book = book
				self.displayBookInfo(book)
			}
		}
	}
}

