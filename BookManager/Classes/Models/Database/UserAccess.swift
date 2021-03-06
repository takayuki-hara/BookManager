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
	static func nextId() -> Int {
		let realm = try! Realm()
		let results = realm.objects(UserObject).sorted("id", ascending: false)
		if results.count == 0 {
			return 1
		}
		return (results.first?.id)! + 1
	}

	static func initAdminUser() {
		// 存在確認し、ない場合はAdminユーザーを登録
		if nextId() == 1 {
			addUser("admin")
		}
	}

	static func addUser(name: String) -> Bool {
		if name.characters.count == 0 {
			return false
		}

		// 存在確認（ある場合はエラー）：同名の人は登録できない
		if checkUser(name) {
			return false
		}

		// 追加
		let realm = try! Realm()
		let user = UserObject()
		user.id = nextId()
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

		// 存在確認（ある場合はOK）
		let realm = try! Realm()
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
