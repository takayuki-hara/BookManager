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
	static func addWishList(data: BookDataModel) -> Bool {
		let realm = try! Realm()

		// 存在確認（ある場合はエラー）
		let results = realm.objects(WishListObject).filter(NSPredicate(format:"isbn == %@", data.isbn!))
		if results.count != 0 {
			return false
		}

		// 追加
		let wishList = WishListObject()
		wishList.isbn = data.isbn!
		wishList.addDate = nowDateString()
		wishList.book = BookAccess.createBookObjectFromBookData(data)
		try! realm.write {
			realm.add(wishList)
		}

		return true
	}

	static func deleteWishList(data: BookDataModel) -> Bool {
		let realm = try! Realm()
		
		// 存在確認（無い場合はエラー）
		let results = realm.objects(WishListObject).filter(NSPredicate(format:"isbn == %@", data.isbn!))
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
			array?.append(BookAccess.createBookDataFromBookObject(result.book!))
		}
		return array
	}

	static func allDeleteWishList() {
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
	
	static func consoleOutWishList() {
		let realm = try! Realm()
		let results = realm.objects(WishListObject)
		for result in results {
			print("\(result.isbn), \(result.addDate), \(result.book?.title)")
		}
	}
}
