//
//  UserObject.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/28.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class UserObject: Object {
	dynamic var id = 0
	dynamic var name = ""

	override class func primaryKey() -> String {
		return "id"
	}
}
