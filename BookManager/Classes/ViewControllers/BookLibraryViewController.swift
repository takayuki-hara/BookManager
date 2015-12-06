//
//  BookLibraryViewController.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/12/06.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit

class BookLibraryViewController: UIViewController {

	// MARK: - @IBOutlet
	@IBOutlet weak var bookDetailView: BookDetailView!

	// MARK: - Property
	var library: BookLibraryDataModel!

	// MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()

		bookDetailView.setBookInfo(library.book)
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

}
