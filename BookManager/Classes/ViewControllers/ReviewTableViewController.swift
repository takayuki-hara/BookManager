//
//  ReviewTableViewController.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/12/06.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit

class ReviewTableViewController: UITableViewController {

	// MARK: - Property
	var reviews: [ReviewDataModel]?

	// MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()

		// xibをテーブルビューのセルとして使う
		let xib = UINib(nibName: "ReviewListTableViewCell", bundle: nil)
		tableView.registerNib(xib, forCellReuseIdentifier: "reviewCell")
		
		// 初期設定
		tableView.delegate = self
		tableView.estimatedRowHeight = 108

		// 右上にEditボタンを表示させる
		navigationItem.rightBarButtonItem = editButtonItem()

		// レビューは全ユーザーを表示させる
		reviews = ReviewAccess.allObjects()
		tableView.reloadData()
    }

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		reviews = ReviewAccess.allObjects()
		tableView.reloadData()
	}

	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	// MARK: - Navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "toReviewSegue" {
			let next = segue.destinationViewController as! ReviewViewController
			if let reviews = reviews {
				next.book = reviews[(tableView.indexPathForSelectedRow?.row)!].book
			}
		}
	}

}

extension ReviewTableViewController {
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let count = reviews?.count else {
			return 0
		}
		return count
    }

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("reviewCell") as! ReviewListTableViewCell
		if reviews == nil {
			return cell
		}
		let review = reviews![indexPath.row]
		cell.setBookInfo(review)
		
		return cell
	}

	// Override to support conditional editing of the table view.
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		let review = reviews![indexPath.row]
		if review.reviewer == getLoginUserFromUserDefaults() {
			return true
		} else {
			return false
		}
	}
	
	// Override to support editing the table view.
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
			// DB削除
			let review = reviews![indexPath.row]
			ReviewAccess.deleteReview(review.id)
			ReviewAccess.consoleOutReviews()
			// テーブルのリストも更新
			reviews?.removeAtIndex(indexPath.row)
			// テーブルのビューを更新
			tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
		}
	}
}

extension ReviewTableViewController {
	// MARK: - UITableViewDelegate
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		performSegueWithIdentifier("toReviewSegue", sender: nil)
	}
}
