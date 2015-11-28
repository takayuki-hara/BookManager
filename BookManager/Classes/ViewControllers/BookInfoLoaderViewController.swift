//
//  BookInfoLoaderViewController.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/23.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit

class BookInfoLoaderViewController: UIViewController {

	// MARK: - @IBOutlet
	@IBOutlet weak var isbnTextField: UITextField!

	// MARK: - @IBAction
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

	// MARK: - Property
	var book: BookDataModel?
	var reader: IsbnReaderView?

	// MARK: - Lifecycle
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
    

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "toBookSearchDetailSegue" {
			let next = segue.destinationViewController as! BookDetailViewController
			if book != nil {
				next.book = book
			}
		}
    }

	// MARK: - Private Methods
	func closeSoftKeyboard() {
		self.view.endEditing(true)
	}

	private func loadBookData(isbn: String) {
		let logic = BookInfoLoaderViewLogic()
		logic.loadBookDataWithIsbn(isbn) { result in
			if let book = result {
				self.book = book
				self.performSegueWithIdentifier("toBookSearchDetailSegue", sender: nil)
			}
		}
	}
}

