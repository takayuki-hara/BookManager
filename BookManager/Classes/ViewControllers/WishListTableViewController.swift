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
	var books: [BookDataModel]?

	// MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()

		// xibをテーブルビューのセルとして使う
		let xib = UINib(nibName: "WishListTableViewCell", bundle: nil)
		tableView.registerNib(xib, forCellReuseIdentifier: "wishListCell")
		
		// 初期設定
		tableView.delegate = self
		tableView.estimatedRowHeight = 108

		//
		books = WishListAccess.allObjects()
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
		guard let count = books?.count else {
			return 0
		}
		return count
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("wishListCell") as! WishListTableViewCell
		if books == nil {
			return cell
		}
		let book = books![indexPath.row]
		
		cell.titleLabel.text = book.title
		cell.authorLabel.text = book.author
		cell.dateLabel.text = book.salesDate
		cell.priceLabel.text = String(book.price!) + " 円"
		cell.reviewLabel.text = String(book.reviewCount!) + " 件"
		if let rating = book.reviewAverage {
			cell.cosmosView.rating = Double(rating)!
			cell.cosmosView.settings.updateOnTouch = false
		}
		let url = NSURL(string: (book.imageUrl!))
		cell.bookImageView.hnk_setImageFromURL(url!)
		
		return cell
	}
	
	/*
	// Override to support conditional editing of the table view.
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}
	*/
	
	/*
	// Override to support editing the table view.
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
			// Delete the row from the data source
			tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
		} else if editingStyle == .Insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		}
	}
	*/
	
	/*
	// Override to support rearranging the table view.
	override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
	
	}
	*/
	
	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		// Return false if you do not want the item to be re-orderable.
		return true
	}
	*/
	
}
