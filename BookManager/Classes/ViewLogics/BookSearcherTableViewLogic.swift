//
//  BookSearcherTableViewLogic.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/25.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class BookSearcherTableViewLogic {

	// MARK: - Public Functions
	func loadBookDataWithWord(word: String, page: Int, loaded: (BookSearchResultModel?) -> ()) {
		var url = BookApiModel.searchApiWithKeyword(word, page: page)
		if word == "オライリー" {
			url = BookApiModel.searchApiWithOreilly(page)
		}
		Alamofire.request(.GET, url)
			.responseObject { (response: Response<BookSearchResultModel, NSError>) in
				print(response.request)  // original URL request
				print(response.response) // URL response
				print(response.result)   // result of response serialization
				
				let data = response.result.value
				loaded(data)
		}
	}

}
