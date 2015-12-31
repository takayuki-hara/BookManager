//
//  BookAccess.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/28.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation

import Foundation
import Realm
import RealmSwift

class BookAccess {
	
	// MARK: - Static Methods
	static func consoleOutBooks() {
		let realm = try! Realm()
		let results = realm.objects(BookObject)
		for result in results {
			log.info("\(result.isbn), \(result.title)")
		}
	}

}
