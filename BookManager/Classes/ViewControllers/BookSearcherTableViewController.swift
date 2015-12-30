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
	var searchWord = ""
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
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "toBookSearchDetailSegue" {
			let next = segue.destinationViewController as! BookDetailViewController
			if let book = books![(tableView.indexPathForSelectedRow?.row)!].item {
				next.book = book
			}
		}
	}

	// MARK: - Private Methods
	private func loadBookData(word: String) {
		if word.characters.count == 0 {
			return
		}

		// 検索ワードが変わっていたら前回の結果はクリアする
		if word != searchWord {
			searchResult = nil
		}

		var page = 1

		// 前回の結果がある場合の処理
		if let lastResult = self.searchResult {
			if lastResult.last == lastResult.count {
				return	// もう無い
			}
			page = lastResult.page! + 1
		}

		searchWord = word
		let logic = BookSearcherTableViewLogic()
		logic.loadBookDataWithWord(searchWord, page: page) { result in
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
		cell.setBookInfo(book)

		return cell
	}
}

extension BookSearcherTableViewController {
	// MARK: - UITableViewDelegate
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		performSegueWithIdentifier("toBookSearchDetailSegue", sender: nil)
	}
	
	override func scrollViewDidScroll(scrollView: UIScrollView) {
		if nowLoading == true {
			return
		}
		let scrollValue = scrollView.contentSize.height - scrollView.bounds.height
		if scrollValue < 44.0 || scrollValue > scrollView.contentOffset.y {
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
