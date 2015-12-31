//
//  WishListTableViewController.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/29.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit
import Cosmos

class WishListTableViewController: UITableViewController {

	// MARK: - Property
	var wishes: [WishListObject]?

	// MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()

		// xibをテーブルビューのセルとして使う
		let xib = UINib(nibName: "WishListTableViewCell", bundle: nil)
		tableView.registerNib(xib, forCellReuseIdentifier: "wishListCell")
		
		// 初期設定
		tableView.delegate = self
		tableView.estimatedRowHeight = 108

		// 右上にEditボタンを表示させる
		navigationItem.rightBarButtonItem = editButtonItem()

		// adminとログインユーザーのみ表示させる
		wishes = WishListAccess.validObjects()
		tableView.reloadData()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	// MARK: - Private Methods
}

extension WishListTableViewController {
	// MARK: - UITableViewDataSource
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let count = wishes?.count else {
			return 0
		}
		return count
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("wishListCell") as! WishListTableViewCell
		if wishes == nil {
			return cell
		}
		let book = wishes![indexPath.row]
		cell.updateCell(book)
		
		return cell
	}
	
	// Override to support conditional editing of the table view.
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return true
	}
	
	// Override to support editing the table view.
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
			// DB削除
			let wish = wishes![indexPath.row]
			WishListAccess.deleteWishList(wish.id)
			WishListAccess.consoleOutWishLists()
			// テーブルのリストも更新
			wishes?.removeAtIndex(indexPath.row)
			// テーブルのビューを更新
			tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
		}
	}
	
}

extension WishListTableViewController {
	// MARK: - UITableViewDelegate
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		if let wishes = wishes {
			let wish = wishes[indexPath.row]
			let controller = ModalBookDetailViewController()
			controller.setupContentView(wish.book!)
			controller.presentPopver(target: self, sourceView: tableView.cellForRowAtIndexPath(indexPath))
		}
	}
}
