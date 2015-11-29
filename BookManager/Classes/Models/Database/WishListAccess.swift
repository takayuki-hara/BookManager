//
//  WishListAccess.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/28.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class WishListAccess {

	// MARK: - Static Methods
	static func countWishLists() -> Int {
		let realm = try! Realm()
		let results = realm.objects(WishListObject)
		return results.count
	}
	
	static func addWishList(data: BookDataModel) -> Bool {
		let realm = try! Realm()

		// 存在確認（ある場合はエラー）:同じ人が同じ本について登録しない
		let results = realm.objects(WishListObject).filter(NSPredicate(format:"isbn == %@ AND wisher == %@", data.isbn!, getLoginUserFromUserDefaults()))
		if results.count != 0 {
			return false
		}

		// BookObjectの追加
		BookAccess.addBook(data)

		// 追加
		let wishList = WishListObject()
		wishList.id = countWishLists() + 1
		wishList.isbn = data.isbn!
		wishList.wisher = getLoginUserFromUserDefaults()
		wishList.addDate = nowDateString()
		try! realm.write {
			realm.add(wishList)
		}

		return true
	}

	static func deleteWishList(data: BookDataModel) -> Bool {
		let realm = try! Realm()
		
		// 存在確認（無い場合はエラー）
		let results = realm.objects(WishListObject).filter(NSPredicate(format:"isbn == %@ AND wisher == %@", data.isbn!, getLoginUserFromUserDefaults()))
		if results.count == 0 {
			return false
		}
		
		// 削除
		try! realm.write {
			realm.delete(results)
		}
		
		return true
	}

	static func allObjects() -> [BookDataModel]? {
		let realm = try! Realm()
		let results = realm.objects(WishListObject)
		var array: [BookDataModel]? = []
		for result in results {
			array?.append(BookAccess.getBook(result.isbn)!)
		}
		return array
	}

	static func allDeleteWishLists() {
		let realm = try! Realm()
		
		// 存在確認（無い場合はエラー）
		let results = realm.objects(WishListObject)
		if results.count == 0 {
			return
		}
		
		// 削除
		try! realm.write {
			realm.delete(results)
		}
	}
	
	static func consoleOutWishLists() {
		let realm = try! Realm()
		let results = realm.objects(WishListObject)
		for result in results {
			print("\(result.id), \(result.isbn), \(result.wisher), \(result.addDate)")
		}
	}
}
