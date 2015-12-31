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
	static func nextId() -> Int {
		let realm = try! Realm()
		let results = realm.objects(WishListObject).sorted("id", ascending: false)
		if results.count == 0 {
			return 1
		}
		return (results.first?.id)! + 1
	}
	
	static func addWishList(data: BookObject) -> Bool {
		let realm = try! Realm()

		// 存在確認（ある場合はエラー）:同じ人が同じ本について登録しない
		let results = realm.objects(WishListObject).filter(NSPredicate(format:"isbn == %@ AND wisher == %@", data.isbn, getLoginUserFromUserDefaults()))
		if results.count != 0 {
			return false
		}

		// 追加
		let wishList = WishListObject()
		wishList.id = nextId()
		wishList.isbn = data.isbn
		wishList.wisher = getLoginUserFromUserDefaults()
		wishList.addDate = nowDateString()
		wishList.book = data
		try! realm.write {
			realm.add(wishList, update: true)
		}

		return true
	}

	static func deleteWishList(id: Int) -> Bool {
		let realm = try! Realm()
		
		// 存在確認（無い場合はエラー）
		let results = realm.objects(WishListObject).filter(NSPredicate(format:"id == %d", id))
		if results.count == 0 {
			return false
		}
		
		// 削除
		try! realm.write {
			realm.delete(results)
		}
		
		return true
	}

	static func validObjects() -> [WishListObject]? {
		let realm = try! Realm()
		let results = realm.objects(WishListObject)
		var array: [WishListObject]? = []
		for result in results {
			//let wish = WishListDataModel(wishList: result)
			if result.wisher == "admin" || result.wisher == getLoginUserFromUserDefaults() {
				array?.append(result)
			}
		}
		return array
	}

	static func allObjects() -> [WishListObject]? {
		let realm = try! Realm()
		let results = realm.objects(WishListObject)
		var array: [WishListObject]? = []
		for result in results {
			//let wish = WishListDataModel(wishList: result)
			array?.append(result)
		}
		return array
	}

//	static func validObjects() -> [WishListDataModel]? {
//		let realm = try! Realm()
//		let results = realm.objects(WishListObject)
//		var array: [WishListDataModel]? = []
//		for result in results {
//			let wish = WishListDataModel(wishList: result)
//			if wish.wisher == "admin" || wish.wisher == getLoginUserFromUserDefaults() {
//				array?.append(wish)
//			}
//		}
//		return array
//	}
	
//	static func allObjects() -> [WishListDataModel]? {
//		let realm = try! Realm()
//		let results = realm.objects(WishListObject)
//		var array: [WishListDataModel]? = []
//		for result in results {
//			let wish = WishListDataModel(wishList: result)
//			array?.append(wish)
//		}
//		return array
//	}

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
			log.info("Wish: \(result.id), \(result.isbn), \(result.wisher), \(result.addDate)")
		}
	}
}
