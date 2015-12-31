//
//  LibraryObject.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/29.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

/// 蔵書情報のRealmオブジェクト
class LibraryObject: Object {
	dynamic var id = 0
	dynamic var isbn = ""
	dynamic var owner = ""
	dynamic var addDate = ""
	dynamic var rentalable = false
	dynamic var isRented = false

	dynamic var book: BookObject?
	
	override class func primaryKey() -> String {
		return "id"
	}
}
