//
//  UserAccess.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/29.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class UserAccess {

	// MARK: - Static Methods
	static func countUsers() -> Int {
		let realm = try! Realm()
		let results = realm.objects(UserObject)
		return results.count
	}

	static func initAdminUser() {
		// 存在確認し、ない場合はAdminユーザーを登録
		if countUsers() == 0 {
			addUser("admin")
		}
	}

	static func addUser(name: String) -> Bool {
		if name.characters.count == 0 {
			return false
		}

		let realm = try! Realm()
		
		// 存在確認（ある場合はエラー）：同名の人は登録できない
		let results = realm.objects(UserObject).filter(NSPredicate(format:"name == %@", name))
		if results.count != 0 {
			return false
		}
		
		// 追加
		let user = UserObject()
		user.id = countUsers() + 1
		user.name = name
		try! realm.write {
			realm.add(user)
		}
		
		return true
	}

	static func checkUser(name: String) -> Bool {
		if name.characters.count == 0 {
			return false
		}
		
		let realm = try! Realm()
		
		// 存在確認（ある場合はOK）
		let results = realm.objects(UserObject).filter(NSPredicate(format:"name == %@", name))
		if results.count != 0 {
			return true
		}

		return false
	}

	static func consoleOutUsers() {
		let realm = try! Realm()
		let results = realm.objects(UserObject)
		for result in results {
			log.info("User: \(result.id), \(result.name)")
		}
	}

}
