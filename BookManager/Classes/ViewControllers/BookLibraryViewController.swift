//
//  BookLibraryViewController.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/12/06.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit

class BookLibraryViewController: UIViewController {

	// MARK: - @IBOutlet
	@IBOutlet weak var bookDetailView: BookDetailView!

	// MARK: - @IBAction
	@IBAction func didPushReviewButton(sender: AnyObject) {
		performSegueWithIdentifier("toReviewSegue", sender: nil)
	}

	@IBAction func didPushRentalButton(sender: AnyObject) {
		if !library.rentalable || library.isRented {
			// アラート表示
			let alertController = UIAlertController(title: "エラー", message: "貸し出し出来ない書籍です", preferredStyle: .Alert)
			let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
			alertController.addAction(defaultAction)
			presentViewController(alertController, animated: true, completion: nil)
		} else {
			performSegueWithIdentifier("toRentalSegue", sender: nil)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "toReviewSegue" {
			let next = segue.destinationViewController as! ReviewViewController
			if let library = library {
				next.library = library
			}
		} else if segue.identifier == "toRentalSegue" {
			let next = segue.destinationViewController as! RentalViewController
			if let library = library {
				next.library = library
			}
		}
	}

}
