//
//  ModalBookDetailViewController.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/12/30.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit

/// 書籍の詳細情報をモーダル表示するクラス
class ModalBookDetailViewController: UIViewController {

	// MARK: - Property
	var contentView = BookDetailView()
	let frameSize = CGSizeMake(350,215)


	// MARK: - Lifecycle
	override func viewDidLoad() {
		let tap = UITapGestureRecognizer(target: self, action: "tapGesture:")
		self.view.addGestureRecognizer(tap)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	// MARK: - Public Method

	/// レイアウトの調整（幅がうまく設定できない、テキストの量で高さを変えたい）
	override func viewDidLayoutSubviews() {
		let textWidth = contentView.frame.size.width - 20
		var newTextSize = contentView.textView.sizeThatFits(CGSizeMake(textWidth, CGFloat.max))
		if newTextSize.width > frameSize.width {
			// sizeThatFitsがとんでもない値を返す場合の対応（原因不明）
			newTextSize.width = frameSize.width
			newTextSize.height = 185
		}
		let newFrame = CGRectMake(0, 0, frameSize.width, frameSize.height + newTextSize.height)
		self.preferredContentSize = newFrame.size
		contentView.frame = newFrame
		contentView.textView.frame.size = newTextSize
	}

	/// コンテンツの初期化
	func setupContentView(book: BookDataModel) {
		contentView.awakeFromNib()
		contentView.hidden = true
		self.view.addSubview(self.contentView)
		
		contentView.setBookInfoCustomColor(book) {
			// 画像が取得できた後に表示させる
			self.contentView.hidden = false
		}
	}
	
	/// ポップアップを表示させる
	func presentPopver(target parent: UIViewController!, sourceView: UIView!) {
		self.modalPresentationStyle = UIModalPresentationStyle.Popover
		self.preferredContentSize = frameSize
		
		let popoverController = self.popoverPresentationController
		popoverController?.delegate = self
		popoverController?.permittedArrowDirections = UIPopoverArrowDirection.Any
		
		popoverController?.sourceView = sourceView
		popoverController?.sourceRect = sourceView.bounds
		
		parent.presentViewController(self, animated: true, completion: nil)
	}


	// MARK: - Internal Method

	/// タップイベント
	func tapGesture(sender: UITapGestureRecognizer){
		self.dismissViewControllerAnimated(false, completion: nil)
	}
	
}

extension ModalBookDetailViewController: UIPopoverPresentationControllerDelegate {
	
	// MARK: - UIPopoverPresentationControllerDelegate
	func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
		return UIModalPresentationStyle.None
	}

}
