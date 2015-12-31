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
	static func nextId() -> Int {
		let realm = try! Realm()
		let results = realm.objects(LibraryObject).sorted("id", ascending: false)
		if results.count == 0 {
			return 1
		}
		return (results.first?.id)! + 1
	}
	
	static func addLibrary(data: BookObject, user: String) -> Bool {
		let realm = try! Realm()
		
		// 存在確認はここでは行わない：同じ所有者が何冊も持っている場合があり得る
		// →チェックはUI上で行う（追加確認など）
		
		// 追加
		let library = LibraryObject()
		library.id = nextId()
		library.isbn = data.isbn
		library.owner = user
		library.addDate = nowDateString()
		library.rentalable = false
		if user == "admin" {
			// Adminユーザーの場合は貸し出し可能とする
			library.rentalable = true
		}
		library.isRented = false
		library.book = data
		try! realm.write {
			realm.add(library, update: true)
		}
		
		return true
	}
	
	static func existLibrary(data: BookObject, user: String) -> Bool {
		let realm = try! Realm()

		// 存在確認
		let results = realm.objects(LibraryObject).filter(NSPredicate(format:"isbn == %@ AND owner == %@", data.isbn, user))
		if results.count == 0 {
			return false
		}

		return true
	}

	static func deleteLibrary(id: Int) -> Bool {
		let realm = try! Realm()
		
		// 存在確認（無い場合はエラー）
		let results = realm.objects(LibraryObject).filter(NSPredicate(format:"id == %d", id))
		if results.count == 0 {
			return false
		}
		
		// 削除
		try! realm.write {
			realm.delete(results)
		}
		
		return true
	}
	
	static func validObjects() -> [LibraryObject]? {
		let realm = try! Realm()
		let results = realm.objects(LibraryObject)
		var array: [LibraryObject]? = []
		for result in results {
			//let lib = BookLibraryDataModel(library: result)
			if result.owner == "admin" || result.owner == getLoginUserFromUserDefaults() {
				array?.append(result)
			}
		}
		return array
	}
	
	static func allObjects() -> [LibraryObject]? {
		let realm = try! Realm()
		let results = realm.objects(LibraryObject)
		var array: [LibraryObject]? = []
		for result in results {
			//let lib = BookLibraryDataModel(library: result)
			array?.append(result)
		}
		return array
	}

//	static func validObjects() -> [BookLibraryDataModel]? {
//		let realm = try! Realm()
//		let results = realm.objects(LibraryObject)
//		var array: [BookLibraryDataModel]? = []
//		for result in results {
//			let lib = BookLibraryDataModel(library: result)
//			if lib.owner == "admin" || lib.owner == getLoginUserFromUserDefaults() {
//				array?.append(lib)
//			}
//		}
//		return array
//	}
//	
//	static func allObjects() -> [BookLibraryDataModel]? {
//		let realm = try! Realm()
//		let results = realm.objects(LibraryObject)
//		var array: [BookLibraryDataModel]? = []
//		for result in results {
//			let lib = BookLibraryDataModel(library: result)
//			array?.append(lib)
//		}
//		return array
//	}
	
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
			log.info("Lib: \(result.id), \(result.isbn), \(result.owner), \(result.addDate)")
		}
	}
}