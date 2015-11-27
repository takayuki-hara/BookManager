//
//  BookApiModel.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/22.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation

struct BookApiModel {
	static let prot = "https://"
	static let host = "app.rakuten.co.jp/"
	static let api = "services/api/BooksBook/Search/20130522?"
	
	static func searchApiWithIsbn(isbn: String) -> String {
		return prot + host + api + "format=json&carrier=1" + "&page=1" + "&isbn=\(isbn)" + "&applicationId=\(appId())"
	}

	static func searchApiWithKeyword(word: String, page:Int) -> String {
		return prot + host + api + "format=json&carrier=1" + "&page=\(page)" + "&title=\(word)" + "&applicationId=\(appId())"
	}
	
	static func appId() -> String {
		// FIXME: 楽天ウェブサービスの applicationId を返してください
		return ""
	}
}
