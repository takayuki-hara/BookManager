//
//  RentalObject.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/28.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

/// レンタル情報のRealmオブジェクト（※非使用）
class RentalObject: Object {
	dynamic var id = 0
	dynamic var isbn = ""
	dynamic var renter = ""
	dynamic var rentDate = ""
	dynamic var isReturned = false

	override class func primaryKey() -> String {
		return "id"
	}
}
