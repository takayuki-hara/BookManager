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
	dynamic var id = 0
	dynamic var isbn = ""
	dynamic var reviewer = ""
	dynamic var addDate = ""
	dynamic var detail = ""
	dynamic var rate = 0.0

	override class func primaryKey() -> String {
		return "id"
	}
}
