//
//  BookObject.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/28.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import ObjectMapper

/// 書籍情報のRealmオブジェクト（ObjectMapperにも対応）
class BookObject: Object {
	dynamic var isbn = ""
	dynamic var title = ""
	dynamic var author = ""
	dynamic var publisher = ""
	dynamic var price = 0
	dynamic var salesDate = ""
	dynamic var itemCaption = ""
	dynamic var itemUrl = ""
	dynamic var imageUrl = ""
	dynamic var reviewCount = 0
	dynamic var reviewAverage = ""
	dynamic var genreId = ""

	override class func primaryKey() -> String {
		return "isbn"
	}

	required convenience init?(_ map: Map) {
		self.init()
	}

}

extension BookObject: Mappable{
	func mapping(map: Map) {
		isbn <- map["isbn"]
		title <- map["title"]
		author <- map["author"]
		publisher <- map["publisherName"]
		price <- map["itemPrice"]
		salesDate <- map["salesDate"]
		itemCaption <- map["itemCaption"]
		itemUrl <- map["itemUrl"]
		imageUrl <- map["largeImageUrl"]
		reviewCount <- map["reviewCount"]
		reviewAverage <- map["reviewAverage"]
		genreId <- map["booksGenreId"]
	}	
}