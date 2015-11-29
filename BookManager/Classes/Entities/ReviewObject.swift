//
//  ReviewObject.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/28.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class ReviewObject: Object {
	dynamic var isbn = ""
	dynamic var reviewer = ""
	dynamic var date = ""
	dynamic var datail = ""
	dynamic var rate = 0.0

	override class func primaryKey() -> String {
		return "isbn"
	}
}
