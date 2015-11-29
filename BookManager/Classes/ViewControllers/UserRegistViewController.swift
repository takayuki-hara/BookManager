//
//  UserRegistViewController.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/29.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit

class UserRegistViewController: UIViewController {

	// MARK: - @IBOutlet
	@IBOutlet weak var userNameText: UITextField!

	// MARK: - @IBAction
	@IBAction func didPushRegistButton(sender: AnyObject) {
		if UserAccess.addUser(userNameText.text!) == false {
			// アラート表示
			let alertController = UIAlertController(title: "ユーザー登録エラー", message: "登録済みのユーザーです", preferredStyle: .Alert)
			let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
			alertController.addAction(defaultAction)
			presentViewController(alertController, animated: true, completion: nil)
		}
		UserAccess.consoleOutUsers()
	}

	// MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()

		// キーボード外のタッチでキーボードを閉じるための設定
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: "closeSoftKeyboard")
		self.view.addGestureRecognizer(gestureRecognizer)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	// MARK: - Private Methods
	func closeSoftKeyboard() {
		self.view.endEditing(true)
	}

}
