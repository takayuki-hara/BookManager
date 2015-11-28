//
//  BookAccess.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/28.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation

import Foundation
import Realm
import RealmSwift
import ObjectMapper

class BookAccess {
	
	// MARK: - Static Methods
	static func createBookObjectFromBookData(data: BookDataModel) -> BookObject {
		let bookObject = BookObject()
		
		bookObject.isbn = data.isbn!
		bookObject.title = data.title!
		bookObject.author = data.author!
		bookObject.publisher = data.publisher!
		bookObject.price = data.price!
		bookObject.salesDate = data.salesDate!
		bookObject.itemCaption = data.itemCaption!
		bookObject.itemUrl = data.itemUrl!
		bookObject.imageUrl = data.imageUrl!
		bookObject.reviewCount = data.reviewCount!
		bookObject.reviewAverage = data.reviewAverage!
		bookObject.genreId = data.genreId!

		return bookObject
	}

	static func createBookDataFromBookObject(object: BookObject) -> BookDataModel {
		let srcObject = [
			"isbn": object.isbn,
			"title": object.title,
			"author": object.author,
			"publisherName": object.publisher,
			"itemPrice": object.price,
			"salesDate": object.salesDate,
			"itemCaption": object.itemCaption,
			"itemUrl": object.itemUrl,
			"largeImageUrl": object.imageUrl,
			"reviewCount": object.reviewCount,
			"reviewAverage": object.reviewAverage,
			"booksGenreId": object.genreId
		]
		
		let bookData = Mapper<BookDataModel>().map(srcObject)
		return bookData!
	}
	
//	static func addWishList(data: BookDataModel) -> Bool {
//		let realm = try! Realm()
//		
//		// 存在確認（ある場合はエラー）
//		let results = realm.objects(WishListObject).filter(NSPredicate(format:"isbn == %@", data.isbn!))
//		if results.count != 0 {
//			return false
//		}
//		
//		// 追加
//		let wishList = WishListObject()
//		wishList.isbn = data.isbn!
//		wishList.addDate = nowDateString()
//		try! realm.write {
//			realm.add(wishList)
//		}
//		
//		return true
//	}
//	
//	static func deleteWishList(data: BookDataModel) -> Bool {
//		let realm = try! Realm()
//		
//		// 存在確認（無い場合はエラー）
//		let results = realm.objects(WishListObject).filter(NSPredicate(format:"isbn == %@", data.isbn!))
//		if results.count == 0 {
//			return false
//		}
//		
//		// 削除
//		try! realm.write {
//			realm.delete(results)
//		}
//		
//		return true
//	}
//	
//	static func allDeleteWishList() {
//		let realm = try! Realm()
//		
//		// 存在確認（無い場合はエラー）
//		let results = realm.objects(WishListObject)
//		if results.count == 0 {
//			return
//		}
//		
//		// 削除
//		try! realm.write {
//			realm.delete(results)
//		}
//	}
//	
//	static func consoleOutWishList() {
//		let realm = try! Realm()
//		let results = realm.objects(WishListObject)
//		for result in results {
//			print(result.isbn)
//		}
//	}
}
