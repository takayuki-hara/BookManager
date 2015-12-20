//
//  IsbnReaderView.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/22.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit
import AVFoundation

final class IsbnReaderView: UIView {

	// MARK: - Property
	var isInitialized = false
	let session = AVCaptureSession()
	var closure: ((String) -> Void)?
	
	// MARK: - Public Functions
	func capture(captured: (isbn: String) -> Void) -> Bool {
		// ２回目以降の実行
		if isInitialized == true {
			session.startRunning()
			return true
		}

		// Device
		let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
		if device == nil {
			return false
		}
		
		// Input
		do {
			let input = try AVCaptureDeviceInput(device: device)
			session.addInput(input)
		} catch let error as NSError {
			log.error(error.debugDescription)
			return false
		}
		
		// Output
		let output = AVCaptureMetadataOutput()
		session.addOutput(output)
		output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
		output.metadataObjectTypes = [AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeQRCode]
		
		// PreView
		let preview = AVCaptureVideoPreviewLayer(session: session)
		preview.videoGravity = AVLayerVideoGravityResizeAspectFill
		preview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
		self.layer.insertSublayer(preview, atIndex: 0)
		
		// Start
		session.startRunning()
		
		// クロージャの保持
		closure = captured

		// 初期化済み
		isInitialized = true

		return true
	}
	
}

extension IsbnReaderView: AVCaptureMetadataOutputObjectsDelegate {
	func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
		// 複数のmetadataが来るので順に調べる
		for data in metadataObjects {
			let obj = data as! AVMetadataObject
			if !obj.isKindOfClass(AVMetadataMachineReadableCodeObject) {
				continue
			}
			let strValue = data.stringValue

			// ISBN13桁かつ97から始まる場合はISBNコードとして認識
			if obj.type == AVMetadataObjectTypeEAN13Code && strValue.hasPrefix("97") {
				log.info(strValue)
				session.stopRunning()
				// クロージャの呼び出し
				closure!(strValue)
			}
		}
	}
}
