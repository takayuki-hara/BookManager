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

class BookObject: RLMObject {
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
}
