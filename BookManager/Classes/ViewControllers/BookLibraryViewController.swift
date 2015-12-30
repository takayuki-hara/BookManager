//
//  BookLibraryViewController.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/12/06.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit
import SCLAlertView

class BookLibraryViewController: UIViewController {

	// MARK: - @IBOutlet
	@IBOutlet weak var bookDetailView: BookDetailView!

	// MARK: - @IBAction
	@IBAction func didPushReviewButton(sender: AnyObject) {
		performSegueWithIdentifier("toReviewSegue", sender: nil)
	}

	@IBAction func didPushTrushButton(sender: AnyObject) {
		if LibraryAccess.deleteLibrary(library.id) {
			SCLAlertView().showSuccess("成功", subTitle: "削除しました")
		} else {
			SCLAlertView().showError("エラー", subTitle: "削除できませんでした")
		}
	}

	// MARK: - Property
	var library: BookLibraryDataModel!

	// MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()

		bookDetailView.setBookInfo(library.book)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	// MARK: - Navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "toReviewSegue" {
			let next = segue.destinationViewController as! ReviewViewController
			if let library = library {
				next.book = library.book
			}
		}
	}

}
