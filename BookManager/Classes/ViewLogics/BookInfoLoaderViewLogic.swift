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

	// MARK: - Public Functions
	func loadBookDataWithIsbn(isbn: String, loaded: (BookObject?) -> ()) {
		Alamofire.request(.GET, BookApiModel.searchApiWithIsbn(isbn))
			.responseObject { (response: Response<BookSearchResultModel, NSError>) in
				log.debug(response.request.debugDescription)  // original URL request
				log.debug(response.response.debugDescription) // URL response
				log.debug(response.result.debugDescription)   // result of response serialization
				
				if let data = response.result.value {
					if let book = data.items?.first?.item {
						loaded(book)
					}
				}
		}
	}

}
