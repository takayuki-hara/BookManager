//
//  WishListDataModel.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/12/06.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation

/// 欲しいものリストデータのクラス
class WishListDataModel {
	var id: Int
	var isbn: String
	var wisher: String
	var addDate: String
	
	var book: BookDataModel
	
	init(wishList: WishListObject) {
		id = wishList.id
		isbn = wishList.isbn
		wisher = wishList.wisher
		addDate = wishList.addDate
		book = BookAccess.getBook(wishList.isbn)!
	}
}
