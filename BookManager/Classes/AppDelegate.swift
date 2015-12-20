//
//  AppDelegate.swift
//  BookManager
//
//  Created by takayuki-hara on 2015/11/23.
//  Copyright © 2015年 takayuki-hara. All rights reserved.
//

import UIKit
import netfox
import XCGLogger
import ChameleonFramework


// for access to appDelegate
let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

// for XCGLogger
let log: XCGLogger = {
	let log = XCGLogger.defaultInstance()
	log.xcodeColorsEnabled = true
	log.xcodeColors = [
		.Verbose: .darkGrey,
		.Debug: .black,
		.Info: .darkGreen,
		.Warning: .orange,
		.Error: .red,
		.Severe: .whiteOnRed
	]
	
	let logPath: NSURL = appDelegate.cacheDirectory.URLByAppendingPathComponent("XCGLogger_Log.txt")
	#if DEBUG
		log.setup(.Debug, showThreadName: true, showLogLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: logPath)
	#else
		log.setup(.Severe, showThreadName: true, showLogLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: logPath)
	#endif
	
	return log
}()


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	// for access to application's directory
	let documentsDirectory: NSURL = {
		let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
		return urls[urls.endIndex - 1]
	}()
	let cacheDirectory: NSURL = {
		let urls = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)
		return urls[urls.endIndex - 1]
	}()

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Override point for customization after application launch.

	#if DEBUG
		// setup netfox
		NFX.sharedInstance().start()

		// キャッシュディレクトリの取得（デバッグ用）
		log.debug("cacheDir=\(documentsDirectory)")
	#endif

		// テーマカラーを設定する（UIパーツの配色が設定される）
		Chameleon.setGlobalThemeUsingPrimaryColor(UIColor.flatMintColor(),
			withSecondaryColor: UIColor.flatOrangeColor(),
			andContentStyle: UIContentStyle.Contrast)

		return true
	}

	func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

	#if DEBUG
		// finalize netfox
		NFX.sharedInstance().stop()
	#endif
	}

}

