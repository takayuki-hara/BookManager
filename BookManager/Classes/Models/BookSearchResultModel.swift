//
//  BookSearchResultModel.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/22.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation
import ObjectMapper

/// API検索結果をそのままマッピングしたデータ
class BookSearchResultModel {
	var count: Int?
	var page: Int?
	var first: Int?
	var last: Int?
	var hits: Int?
	var carrier: Int?
	var pageCount: Int?
	var items: [BookDataParentModel]?

	required init?(_ map: Map) {}
}

extension BookSearchResultModel: Mappable {
	func mapping(map: Map) {
		count <- map["count"]
		page <- map["page"]
		first <- map["first"]
		last <- map["last"]
		hits <- map["hits"]
		carrier <- map["carrier"]
		pageCount <- map["pageCount"]

		items <- map["Items"]
	}
}



/// API結果のマッピングのためだけの階層
class BookDataParentModel {
	var item: BookObject?
	
	required init?(_ map: Map) {}
}

extension BookDataParentModel: Mappable {
	func mapping(map: Map) {
		item <- map["Item"]
	}
}
