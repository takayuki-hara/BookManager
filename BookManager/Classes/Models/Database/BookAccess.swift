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

}
