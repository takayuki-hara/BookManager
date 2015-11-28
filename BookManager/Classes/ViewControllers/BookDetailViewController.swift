//
//  BookDetailViewController.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/28.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit
import Cosmos
import Haneke

class BookDetailViewController: UIViewController {

	enum MenuType {
		case Info, Search, Library, WishList
	}

	// MARK: - @IBOutlet
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var bookImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var cosmosView: CosmosView!
	@IBOutlet weak var reviewLabel: UILabel!
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var textView: UITextView!

	@IBAction func didPushWishListButton(sender: AnyObject) {
	}

	@IBAction func didPushLibraryButton(sender: AnyObject) {
	}

	@IBAction func didPushReviewButton(sender: AnyObject) {
	}
	
	// MARK: - Property
	var book: BookDataModel!
	var menu: MenuType!

	// MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		displayBookInfo(book)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

	// MARK: - Private Methods
	private func displayBookInfo(book: BookDataModel) {
		let url = NSURL(string: book.largeImageUrl!)
		bookImageView.hnk_setImageFromURL(url!)
		
		titleLabel.text = book.title
		authorLabel.text = book.author
		
		if let rating = book.reviewAverage {
			cosmosView.rating = Double(rating)!
			cosmosView.settings.updateOnTouch = false
		}
		reviewLabel.text = String(book.reviewCount!) + " 件"
		
		priceLabel.text = String(book.itemPrice!) + " 円"
		dateLabel.text = book.salesDate
		textView.text = book.itemCaption
	}
	
}
