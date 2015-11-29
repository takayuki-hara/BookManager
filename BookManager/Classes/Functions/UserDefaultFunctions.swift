//
//  UserDefaultFunctions.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/29.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation

let kUserDefaultKeyLoginUser = "login_user"

func setLoginUserToUserDefaults(name: String) {
	let ud = NSUserDefaults.standardUserDefaults()
	ud.setObject(name, forKey: kUserDefaultKeyLoginUser)
}

func getLoginUserFromUserDefaults() -> String {
	let ud = NSUserDefaults.standardUserDefaults()
	if let user = ud.objectForKey(kUserDefaultKeyLoginUser) {
		return user as! String
	}
	return "Identification"
}
