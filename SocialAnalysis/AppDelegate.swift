//
//  AppDelegate.swift
//  SocialAnalysis
//
//  Created by DAO VAN UOC on 12/9/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import TwitterKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = MainVC(nibName: nil, bundle: nil)
        self.window?.rootViewController = mainVC
        self.window?.makeKeyAndVisible()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        TWTRTwitter.sharedInstance().start(withConsumerKey:"c9TcEZR0HYrw4TmqURJusggte", consumerSecret:"NueXXy9Xm22o0uybOhwXGuxKgIOYOHtnQejQbuxTdrN2KIJbjn")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        TWTRTwitter.sharedInstance().application(app, open: url, options: options)
        return true
    }

}

