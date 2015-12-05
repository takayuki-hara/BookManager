//
//  BookLibraryDataModel.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/12/05.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation

class BookLibraryDataModel {
	var id: Int
	var isbn: String
	var owner: String
	var addDate: String
	var rentalable: Bool
	var isRented: Bool

	var book: BookDataModel
	
	init(library: LibraryObject) {
		id = library.id
		isbn = library.isbn
		owner = library.owner
		addDate = library.addDate
		rentalable = library.rentalable
		isRented = library.isRented
		book = BookAccess.getBook(library.isbn)!
	}
}
