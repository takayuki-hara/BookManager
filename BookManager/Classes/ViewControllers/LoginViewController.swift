//
//  LoginViewController.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/23.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	// MARK: - @IBOutlet
	@IBOutlet weak var userNameText: UITextField!

	// MARK: - @IBAction
	@IBAction func didPushLoginButton(sender: AnyObject) {
		if UserAccess.checkUser(userNameText.text!) == true {
			setLoginUserToUserDefaults(userNameText.text!)
			performSegueWithIdentifier("toHomeViewSegue", sender: nil)
		} else {
			// アラート表示
			let alertController = UIAlertController(title: "ログインエラー", message: "登録されたユーザーではありません", preferredStyle: .Alert)
			let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
			alertController.addAction(defaultAction)
			presentViewController(alertController, animated: true, completion: nil)
		}
	}

	// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

		// Adminユーザーの確認（なければ追加）
		UserAccess.initAdminUser()

		// 前回のログインユーザー名を表示しておく
		userNameText.text = getLoginUserFromUserDefaults()

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
