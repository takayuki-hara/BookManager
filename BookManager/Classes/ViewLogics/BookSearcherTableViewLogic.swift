//
//  BookSearcherTableViewLogic.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/25.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import Haneke

class BookSearcherTableViewLogic {
	func loadBookDataWithWord(word: String, page: Int, loaded: (BookSearchResultModel?) -> ()) {
		Alamofire.request(.GET, BookApiModel.searchApiWithKeyword(word, page: page))
			.responseObject { (response: Response<BookSearchResultModel, NSError>) in
				print(response.request)  // original URL request
				print(response.response) // URL response
				print(response.result)   // result of response serialization
				
				let data = response.result.value
				loaded(data)
		}
	}

}
