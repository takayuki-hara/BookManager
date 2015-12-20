//
//  UserRegistViewController.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/29.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit
import SCLAlertView

class UserRegistViewController: UIViewController {

	// MARK: - @IBOutlet
	@IBOutlet weak var userNameText: UITextField!

	// MARK: - @IBAction
	@IBAction func didPushRegistButton(sender: AnyObject) {
		if UserAccess.addUser(userNameText.text!) == false {
			SCLAlertView().showNotice("登録済みユーザー", subTitle: "既に登録されています")
		} else {
			SCLAlertView().showSuccess("ユーザー登録", subTitle: "\(userNameText.text!) さんを登録しました")
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
