//
//  BookInfoLoaderViewLogic.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/23.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class BookInfoLoaderViewLogic {
	func loadBookDataWithIsbn(isbn: String, loaded: (BookDataModel?) -> ()) {
		Alamofire.request(.GET, BookApiModel.searchApiWithIsbn(isbn))
			.responseObject { (response: Response<BookSearchResultModel, NSError>) in
				print(response.request)  // original URL request
				print(response.response) // URL response
				print(response.result)   // result of response serialization
				
				let data = response.result.value
				loaded(data?.items?.first?.item)
		}
	}
}
