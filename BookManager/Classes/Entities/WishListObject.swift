//
//  WishListObject.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/28.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class WishListObject: Object {
	dynamic var id = 0
	dynamic var isbn = ""
	dynamic var wisher = ""
	dynamic var addDate = ""

	override class func primaryKey() -> String {
		return "id"
	}
}
