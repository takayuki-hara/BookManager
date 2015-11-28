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

class WishListObject: RLMObject {
	dynamic var isbn = ""
	dynamic var addDate = ""

	override class func primaryKey() -> String {
		return "isbn"
	}
}
