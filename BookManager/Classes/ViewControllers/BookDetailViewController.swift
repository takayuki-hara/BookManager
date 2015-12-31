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
import SCLAlertView

class BookDetailViewController: UIViewController {

	// MARK: - @IBOutlet
	@IBOutlet weak var bookDetailView: BookDetailView!

	// MARK: - @IBAction
	@IBAction func didPushWishListButton(sender: AnyObject) {
		if WishListAccess.addWishList(book) == false {
			SCLAlertView().showNotice("登録エラー", subTitle: "登録済みです")
		} else {
			SCLAlertView().showSuccess("欲しいものリスト登録", subTitle: "登録しました")
		}
		WishListAccess.consoleOutWishLists()
	}

	@IBAction func didPushLibraryButton(sender: AnyObject) {
		if LibraryAccess.existLibrary(book, user: getLoginUserFromUserDefaults()) {
			let alertView = SCLAlertView()
			alertView.addButton("追加登録") {
				log.debug("pushed OK!")
				self.addLibrary()
			}
			alertView.addButton("CANCEL") {
				log.debug("Pushed CANCEL!")
				return
			}
			alertView.showWarning("確認", subTitle: "登録済みの書籍です。追加登録しますか？")
		} else {
			addLibrary()
		}
	}

	// MARK: - Property
	var book: BookObject!

	// MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		bookDetailView.updateView(book)
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
			SCLAlertView().showError("登録エラー", subTitle: "登録済みの書籍です")
		} else {
			SCLAlertView().showSuccess("蔵書登録", subTitle: "登録しました")
		}
		LibraryAccess.consoleOutLibraries()
	}
}
