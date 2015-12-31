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
	
	static func addReview(data: BookObject, rate: Double, detail: String, update: Bool = false) -> Bool {
		let realm = try! Realm()
		
		// 存在確認（更新でなく既存の場合はエラー）:同じ人が同じ本について登録しない
		let exist = existReview(data, user: getLoginUserFromUserDefaults())
		if !update && exist != nil {
			return false
		}
		
		// 追加
		let review = ReviewObject()
		review.id = nextId()
		if let exist = exist {
			review.id = exist
		}
		review.isbn = data.isbn
		review.reviewer = getLoginUserFromUserDefaults()
		review.addDate = nowDateString()
		review.rate = rate
		review.detail = detail
		review.book = data
		try! realm.write {
			realm.add(review, update: true)
		}
		
		return true
	}

	static func existReview(data: BookObject, user: String) -> Int? {
		let realm = try! Realm()
		
		// 存在確認
		let results = realm.objects(ReviewObject).filter(NSPredicate(format:"isbn == %@ AND reviewer == %@", data.isbn, user))
		if results.count == 0 {
			return nil
		}
		
		return results.first!.id
	}
	
	static func deleteReview(id: Int) -> Bool {
		let realm = try! Realm()
		
		// 存在確認（無い場合はエラー）
		let results = realm.objects(ReviewObject).filter(NSPredicate(format:"id == %d", id))
		if results.count == 0 {
			return false
		}
		
		// 削除
		try! realm.write {
			realm.delete(results)
		}
		
		return true
	}
	
	static func getReview(data: BookObject, user: String) -> ReviewObject? {
		let realm = try! Realm()
		
		// 存在確認（ない場合はエラー）
		let results = realm.objects(ReviewObject).filter(NSPredicate(format:"isbn == %@ AND reviewer == %@", data.isbn, user))
		if results.count == 0 {
			return nil
		}
		
		return results.first
	}
	
	static func allObjects() -> [ReviewObject]? {
		let realm = try! Realm()
		let results = realm.objects(ReviewObject)
		var array: [ReviewObject]? = []
		for result in results {
			array?.append(result)
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
