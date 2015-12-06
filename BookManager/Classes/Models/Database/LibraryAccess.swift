//
//  LibraryAccess.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/29.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class LibraryAccess {
	
	// MARK: - Static Methods
	static func countLibraries() -> Int {
		let realm = try! Realm()
		let results = realm.objects(LibraryObject)
		return results.count
	}
	
	static func addLibrary(data: BookDataModel, user: String) -> Bool {
		let realm = try! Realm()
		
		// 存在確認はここでは行わない：同じ所有者が何冊も持っている倍があり得る
		// →チェックはUI上で行う（追加確認など）
		
		// BookObjectの追加
		BookAccess.addBook(data)
		
		// 追加
		let library = LibraryObject()
		library.id = countLibraries() + 1
		library.isbn = data.isbn!
		library.owner = user
		library.addDate = nowDateString()
		library.rentalable = false
		if user == "admin" {
			// Adminユーザーの場合は貸し出し可能とする
			library.rentalable = true
		}
		library.isRented = false
		try! realm.write {
			realm.add(library)
		}
		
		return true
	}
	
	static func existLibrary(data: BookDataModel, user: String) -> Bool {
		let realm = try! Realm()

		// 存在確認
		let results = realm.objects(LibraryObject).filter(NSPredicate(format:"isbn == %@ AND owner == %@", data.isbn!, user))
		if results.count == 0 {
			return false
		}

		return true
	}

	static func deleteWishList(data: BookDataModel) -> Bool {
		let realm = try! Realm()
		
		// 存在確認（無い場合はエラー）
		let results = realm.objects(LibraryObject).filter(NSPredicate(format:"isbn == %@", data.isbn!))
		if results.count == 0 {
			return false
		}
		
		// 削除
		try! realm.write {
			realm.delete(results)
		}
		
		return true
	}
	
	static func allObjects() -> [BookLibraryDataModel]? {
		let realm = try! Realm()
		let results = realm.objects(LibraryObject)
		var array: [BookLibraryDataModel]? = []
		for result in results {
			let lib = BookLibraryDataModel(library: result)
			array?.append(lib)
		}
		return array
	}
	
	static func allDeleteLibraries() {
		let realm = try! Realm()
		
		// 存在確認（無い場合はエラー）
		let results = realm.objects(LibraryObject)
		if results.count == 0 {
			return
		}
		
		// 削除
		try! realm.write {
			realm.delete(results)
		}
	}
	
	static func consoleOutLibraries() {
		let realm = try! Realm()
		let results = realm.objects(LibraryObject)
		for result in results {
			print("Lib: \(result.id), \(result.isbn), \(result.owner), \(result.addDate)")
		}
	}
}