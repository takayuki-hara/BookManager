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
//	static func addBook(book: BookDataModel) -> Bool {
//		let realm = try! Realm()
//		
//		// 追加（isbnが同じ場合は更新される）
//		let data = createBookObjectFromBookData(book)
//		try! realm.write {
//			realm.add(data, update: true)
//		}
//		
//		return true
//	}
	
//	static func getBook(isbn: String) -> BookDataModel? {
//		let realm = try! Realm()
//		
//		// 存在確認（ない場合はエラー）
//		let results = realm.objects(BookObject).filter(NSPredicate(format:"isbn == %@", isbn))
//		if results.count == 0 {
//			return nil
//		}
//		
//		return createBookDataFromBookObject(results.first!)
//	}
	
	static func consoleOutBooks() {
		let realm = try! Realm()
		let results = realm.objects(BookObject)
		for result in results {
			log.info("\(result.isbn), \(result.title)")
		}
	}

	
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

//	static func createBookDataFromBookObject(object: BookObject) -> BookDataModel {
//		let srcObject = [
//			"isbn": object.isbn,
//			"title": object.title,
//			"author": object.author,
//			"publisherName": object.publisher,
//			"itemPrice": object.price,
//			"salesDate": object.salesDate,
//			"itemCaption": object.itemCaption,
//			"itemUrl": object.itemUrl,
//			"largeImageUrl": object.imageUrl,
//			"reviewCount": object.reviewCount,
//			"reviewAverage": object.reviewAverage,
//			"booksGenreId": object.genreId
//		]
//		
//		let bookData = Mapper<BookDataModel>().map(srcObject)
//		return bookData!
//	}
}
