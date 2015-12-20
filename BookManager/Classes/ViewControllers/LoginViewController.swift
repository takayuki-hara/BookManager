//
//  LoginViewController.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/23.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit
import SCLAlertView

class LoginViewController: UIViewController {

	// MARK: - @IBOutlet
	@IBOutlet weak var userNameText: UITextField!

	// MARK: - @IBAction
	@IBAction func didPushLoginButton(sender: AnyObject) {
		if UserAccess.checkUser(userNameText.text!) == true {
			setLoginUserToUserDefaults(userNameText.text!)
			performSegueWithIdentifier("toHomeViewSegue", sender: nil)
		} else {
			SCLAlertView().showError("ログインエラー", subTitle: "登録されたユーザーではありません")
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
