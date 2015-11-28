//
//  BookDataModel.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/22.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation
import ObjectMapper

/// API検索結果の書籍一冊分のデータのうち必要なものだけ抽出したもの
class BookDataModel {
	var isbn: String?
	var title: String?
	var author: String?
	var publisherName: String?
	var itemPrice: Int?
	var salesDate: String?
	var itemCaption: String?
	var itemUrl: String?
	var largeImageUrl: String?
	var reviewCount: Int?
	var reviewAverage: String?
	var booksGenreId: String?
	
	required init?(_ map: Map) {}
}

extension BookDataModel: Mappable {
	func mapping(map: Map) {
		isbn <- map["isbn"]
		title <- map["title"]
		author <- map["author"]
		publisherName <- map["publisherName"]
		itemPrice <- map["itemPrice"]
		salesDate <- map["salesDate"]
		itemCaption <- map["itemCaption"]
		itemUrl <- map["itemUrl"]
		largeImageUrl <- map["largeImageUrl"]
		reviewCount <- map["reviewCount"]
		reviewAverage <- map["reviewAverage"]
		booksGenreId <- map["booksGenreId"]
	}
}


/// API結果のマッピングのためだけの階層
class BookDataParentModel {
	var item: BookDataModel?
	
	required init?(_ map: Map) {}
}

extension BookDataParentModel: Mappable {
	func mapping(map: Map) {
		item <- map["Item"]
	}
}
