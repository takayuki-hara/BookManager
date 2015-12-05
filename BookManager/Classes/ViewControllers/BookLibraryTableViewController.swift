//
//  BookLibraryTableViewController.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/23.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit

class BookLibraryTableViewController: UITableViewController {

	// MARK: - Property
	var libraries: [BookLibraryDataModel]?
	
	// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

		// xibをテーブルビューのセルとして使う
		let xib = UINib(nibName: "BookLibraryTableViewCell", bundle: nil)
		tableView.registerNib(xib, forCellReuseIdentifier: "libraryCell")
		
		// 初期設定
		tableView.delegate = self
		tableView.estimatedRowHeight = 108
		
		//
		libraries = LibraryAccess.allObjects()
		tableView.reloadData()
    }

	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		// Get the new view controller using segue.destinationViewController.
		// Pass the selected object to the new view controller.
	}
	*/
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	// MARK: - Private Mothods
}

extension BookLibraryTableViewController {
    // MARK: - UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let count = libraries?.count else {
			return 0
		}
		return count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("libraryCell") as! BookLibraryTableViewCell
		if libraries == nil {
			return cell
		}
		let library = libraries![indexPath.row]
		
		cell.titleLabel.text = library.book.title
		cell.authorLabel.text = library.book.author
		cell.dateLabel.text = library.addDate
		cell.ownerLabel.text = library.owner
		cell.reviewLabel.text = String(library.book.reviewCount!) + " 件"
		if let rating = library.book.reviewAverage {
			cell.cosmosView.rating = Double(rating)!
			cell.cosmosView.settings.updateOnTouch = false
		}
		let url = NSURL(string: (library.book.imageUrl!))
		cell.bookImageView.hnk_setImageFromURL(url!)
		
		return cell
    }

}
