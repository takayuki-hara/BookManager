//
//  ReviewAccess.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/12/06.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class ReviewAccess {

	// MARK: - Static Methods
	static func nextId() -> Int {
		let realm = try! Realm()
		let results = realm.objects(ReviewObject).sorted("id", ascending: false)
		if results.count == 0 {
			return 1
		}
		return (results.first?.id)! + 1
	}
	
	static func addReview(data: BookDataModel, rate: Double, detail: String, update: Bool = false) -> Bool {
		let realm = try! Realm()
		
		// 存在確認（ある場合はエラー）:同じ人が同じ本について登録しない
		if !update {
			let results = realm.objects(ReviewObject).filter(NSPredicate(format:"isbn == %@ AND reviewer == %@", data.isbn!, getLoginUserFromUserDefaults()))
			if results.count != 0 {
				return false
			}
		}
		
		// BookObjectの追加（今のところ蔵書しかレビューしないので不要）
		// BookAccess.addBook(data)
		
		// 追加
		let review = ReviewObject()
		review.id = nextId()
		review.isbn = data.isbn!
		review.reviewer = getLoginUserFromUserDefaults()
		review.addDate = nowDateString()
		review.rate = rate
		review.detail = detail
		try! realm.write {
			realm.add(review, update: true)
		}
		
		return true
	}

	static func deleteReview(data: BookDataModel) -> Bool {
		let realm = try! Realm()
		
		// 存在確認（無い場合はエラー）
		let results = realm.objects(ReviewObject).filter(NSPredicate(format:"isbn == %@ AND reviewer == %@", data.isbn!, getLoginUserFromUserDefaults()))
		if results.count == 0 {
			return false
		}
		
		// 削除
		try! realm.write {
			realm.delete(results)
		}
		
		return true
	}
	
	static func allObjects() -> [ReviewDataModel]? {
		let realm = try! Realm()
		let results = realm.objects(ReviewObject)
		var array: [ReviewDataModel]? = []
		for result in results {
			let review = ReviewDataModel(review: result)
			array?.append(review)
		}
		return array
	}

	static func allDeleteReview() {
		let realm = try! Realm()
		
		// 存在確認（無い場合はエラー）
		let results = realm.objects(ReviewObject)
		if results.count == 0 {
			return
		}
		
		// 削除
		try! realm.write {
			realm.delete(results)
		}
	}
	
	static func consoleOutReviews() {
		let realm = try! Realm()
		let results = realm.objects(ReviewObject)
		for result in results {
			log.info("Review: \(result.id), \(result.isbn), \(result.reviewer), \(result.addDate), \(result.rate)")
		}
	}
}
