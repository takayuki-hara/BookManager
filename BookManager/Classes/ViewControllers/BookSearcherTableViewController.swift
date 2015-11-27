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

	@IBOutlet weak var searchBar: UISearchBar!

	var books: BookSearchResultModel?
	
	override func viewDidLoad() {
        super.viewDidLoad()

		// xibをテーブルビューのセルとして使う
		let xib = UINib(nibName: "BookSearcherTableViewCell", bundle: nil)
		tableView.registerNib(xib, forCellReuseIdentifier: "bookSearcherCell")
		
		searchBar.delegate = self
		//tableView.delegate = self
		tableView.estimatedRowHeight = 108
		//tableView.rowHeight = UITableViewAutomaticDimension

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

	private func loadBookData(word: String) {
		let logic = BookSearcherTableViewLogic()
		logic.loadBookDataWithWord(word, page: 1) { result in
			if let books = result {
				self.books = books
				self.tableView.reloadData()
			}
		}
	}
}

extension BookSearcherTableViewController {
	// MARK: - Table view data source
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		if let array = books?.items {
			return array.count
		}
		return 0
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("bookSearcherCell") as! BookSearcherTableViewCell

		guard let book = books?.items![indexPath.row].item else {
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
	
//	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//		print("didselect")
//	}

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
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		// Get the new view controller using segue.destinationViewController.
		// Pass the selected object to the new view controller.
	}
	*/
	
}

extension BookSearcherTableViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		loadBookData(searchBar.text!)
		searchBar.resignFirstResponder()
	}
}
