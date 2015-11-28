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
	var publisher: String?
	var price: Int?
	var salesDate: String?
	var itemCaption: String?
	var itemUrl: String?
	var imageUrl: String?
	var reviewCount: Int?
	var reviewAverage: String?
	var genreId: String?
	
	required init?(_ map: Map) {}
}

extension BookDataModel: Mappable {
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
