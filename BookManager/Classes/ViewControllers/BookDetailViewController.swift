//
//  BookDetailViewController.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/28.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit
import Cosmos
import Haneke

class BookDetailViewController: UIViewController {

	// MARK: - @IBOutlet
	@IBOutlet weak var bookDetailView: BookDetailView!

	// MARK: - @IBAction
	@IBAction func didPushWishListButton(sender: AnyObject) {
		if WishListAccess.addWishList(book) == false {
			// アラート表示
			let alertController = UIAlertController(title: "登録エラー", message: "登録済みの書籍です", preferredStyle: .Alert)
			let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
			alertController.addAction(defaultAction)
			presentViewController(alertController, animated: true, completion: nil)
		}
		WishListAccess.consoleOutWishLists()
	}

	@IBAction func didPushLibraryButton(sender: AnyObject) {
		if LibraryAccess.existLibrary(book, user: getLoginUserFromUserDefaults()) {
			let alertController = UIAlertController(title: "確認", message: "登録済みの書籍です。追加登録しますか？", preferredStyle: .Alert)
			let otherAction = UIAlertAction(title: "OK", style: .Default) { action in
				print("pushed OK!")
				self.addLibrary()
			}
			let cancelAction = UIAlertAction(title: "CANCEL", style: .Cancel) { action in
				print("Pushed CANCEL!")
				return
			}
			alertController.addAction(otherAction)
			alertController.addAction(cancelAction)
			presentViewController(alertController, animated: true, completion: nil)
		} else {
			addLibrary()
		}
	}

	@IBAction func didPushReviewButton(sender: AnyObject) {
		//
	}
	
	// MARK: - Property
	var book: BookDataModel!

	// MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		bookDetailView.setBookInfo(book)
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
	private func addLibrary() {
		if LibraryAccess.addLibrary(book, user: getLoginUserFromUserDefaults()) == false {
			// アラート表示
			let alertController = UIAlertController(title: "登録エラー", message: "登録済みの書籍です", preferredStyle: .Alert)
			let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
			alertController.addAction(defaultAction)
			presentViewController(alertController, animated: true, completion: nil)
		}
		LibraryAccess.consoleOutLibraries()
	}
}
