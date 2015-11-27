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

//	func loadImage(url: String, loaded: (UIImage) -> ()) {
//		let cache = Shared.imageCache
//		
//		let iconFormat = Format<UIImage>(name: "icons", diskCapacity: 10 * 1024 * 1024) { image in
//			return image
//		}
//		cache.addFormat(iconFormat)
//		
//		let URL = NSURL(string: url)!
//		cache.fetch(URL: URL, formatName: "icons").onSuccess { image in
//			loaded(image)
//		}
//	}
}
