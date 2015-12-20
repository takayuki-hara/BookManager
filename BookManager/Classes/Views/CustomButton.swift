//
//  CustomButton.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/12/20.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

	// MARK: - Property

	// 角丸の半径(0で四角形)
	@IBInspectable var cornerRadius: CGFloat = 5.0

	// 枠
	@IBInspectable var borderColor: UIColor = UIColor.clearColor()
	@IBInspectable var borderWidth: CGFloat = 0.0

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
		// 角丸
		self.layer.cornerRadius = cornerRadius
		self.clipsToBounds = (cornerRadius > 0)
		
		// 枠線
		self.layer.borderColor = borderColor.CGColor
		self.layer.borderWidth = borderWidth
		
		super.drawRect(rect)
	}

}
