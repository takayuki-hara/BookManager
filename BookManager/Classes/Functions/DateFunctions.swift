//
//  DateFunctions.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/28.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation

func nowDateString() -> String {
	let dateFormatter = NSDateFormatter()
	dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
	dateFormatter.dateFormat = "yyyy/MM/dd"
	return dateFormatter.stringFromDate(NSDate())
}

