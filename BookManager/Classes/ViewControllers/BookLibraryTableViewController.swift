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
		
		// adminとログインユーザーのみ表示させる
		libraries = LibraryAccess.validObjects()
		tableView.reloadData()
    }

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		libraries = LibraryAccess.validObjects()
		tableView.reloadData()
	}

	// MARK: - Navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "toBookLibrarySegue" {
			let next = segue.destinationViewController as! BookLibraryViewController
			
			if let libraries = libraries {
				next.library = libraries[(tableView.indexPathForSelectedRow?.row)!]
			}
		}
	}
	
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
		cell.setBookInfo(library)
		
		return cell
    }

}

extension BookLibraryTableViewController {
	// MARK: - UITableViewDelegate
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		performSegueWithIdentifier("toBookLibrarySegue", sender: nil)
	}
}
