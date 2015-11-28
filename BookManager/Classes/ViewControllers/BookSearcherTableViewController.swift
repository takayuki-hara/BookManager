//
//  BookSearcherTableViewController.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/23.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit
import Cosmos

class BookSearcherTableViewController: UITableViewController {

	// MARK: - @IBOutlet
	@IBOutlet weak var searchBar: UISearchBar!

	// MARK: - Property
	var searchResult: BookSearchResultModel?
	var books: [BookDataParentModel]?
	var nowLoading = false

	// MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()

		// xibをテーブルビューのセルとして使う
		let xib = UINib(nibName: "BookSearcherTableViewCell", bundle: nil)
		tableView.registerNib(xib, forCellReuseIdentifier: "bookSearcherCell")

		// 初期設定
		searchBar.delegate = self
		tableView.delegate = self
		tableView.estimatedRowHeight = 108
		//tableView.rowHeight = UITableViewAutomaticDimension

		// キーボード外のタッチでキーボードを閉じるための設定
		// MEMO:TableViewではUITapGestureRecognizerを使うとセルのタップが検知できない
		//		そのためUIScrollViewのkeyboardDismissModeを設定する（Storyboardにて）
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
	private func loadBookData(word: String) {
		var page = 1

		// 前回の結果がある場合の処理
		if let lastResult = self.searchResult {
			if lastResult.last == lastResult.count {
				return	// もう無い
			}
			page++
		}

		let logic = BookSearcherTableViewLogic()
		logic.loadBookDataWithWord(word, page: page) { result in
			self.nowLoading = false
			if let result = result {
				self.searchResult = result
				if result.page == 1 {
					self.books = result.items
				} else {
					// MEMO:両者アンラップしたものを再設定するしか方法が見つからなかった
					self.books = self.books! + result.items!
				}
				self.tableView.reloadData()
			}
		}
		nowLoading = true
	}
}

extension BookSearcherTableViewController {
	// MARK: - UITableViewDataSource
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let count = books?.count else {
			return 0
		}
		return count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("bookSearcherCell") as! BookSearcherTableViewCell

		guard let book = books![indexPath.row].item else {
			return cell
		}
		print(indexPath.row)

		cell.titleLabel.text = book.title
		cell.authorLabel.text = book.author
		cell.dateLabel.text = book.salesDate
		cell.priceLabel.text = String(book.itemPrice!) + " 円"
		cell.reviewLabel.text = String(book.reviewCount!) + " 件"

		if let rating = book.reviewAverage {
			cell.cosmosView.rating = Double(rating)!
			cell.cosmosView.settings.updateOnTouch = false
		}

		let url = NSURL(string: (book.largeImageUrl!))
		cell.bookImageView.hnk_setImageFromURL(url!)

		return cell
	}
}

extension BookSearcherTableViewController {
	// MARK: - UITableViewDelegate
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let cell = tableView.cellForRowAtIndexPath(indexPath) as! BookSearcherTableViewCell
		print(cell.titleLabel.text)
		performSegueWithIdentifier("toBookSearchDetailSegue", sender: nil)
	}
	
	override func scrollViewDidScroll(scrollView: UIScrollView) {
		if nowLoading == true {
			return
		}
		
		let scrollValue = scrollView.contentSize.height - scrollView.bounds.height
		if scrollValue > scrollView.contentOffset.y {
			return
		}
		
		// 一番下までスクロールしたというこでデータを追加する
		loadBookData(searchBar.text!)
	}
}

extension BookSearcherTableViewController: UISearchBarDelegate {
	// MARK: - UISearchBarDelegate
	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		loadBookData(searchBar.text!)
		searchBar.resignFirstResponder()
	}
}
