//
//  GlobalDefine.swift
//  SecretSanta
//
//  Created by DAO VAN UOC on 11/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit
//let kAdmobAppID     = "ca-app-pub-1947012962477196/3445976267"
//let kAdmobUnitID    = "ca-app-pub-1947012962477196/7876175862"

let kAdmobAppID         = "ca-app-pub-1947012962477196~8459063867"
let kAdmobBanner        = "ca-app-pub-1947012962477196/2412530261"
let kAdmobInterstitial  = "ca-app-pub-1947012962477196/2272929463"

let bundle_APP_ID       = "Secretsanta.com.christmas"

let APPLE_APP_ID        = "1163523909"

let URL_SHARE           = String.init(format: "https://itunes.apple.com/app/id%@",APPLE_APP_ID)

let XAppDelegate    = UIApplication.shared.delegate as! AppDelegate
let KEY_FAVORITE    = "KEY_FAVORITE"
let KEY_SNOW        = "KEY_SNOW"
typealias DataCallBackSuccess = (Any?) -> Void
typealias DataCallBackError   = (Error?)   -> Void


let DOMAIN_FIREBASE = "https://firebasestorage.googleapis.com/v0/b/christmasringtones-27b22.appspot.com/o/"

struct COLOR {
    static let APP_COLOR = UIColor(hexString: "58D591")
    static let CELL_COLOR = UIColor(hexString: "7c0406")
    static let TABBAR_COLOR = UIColor(hexString: "80dd75")
    static let NAME_MUSIC = UIColor(hexString: "11783f")
}

struct REQUEST {
    static let TIME_OUT = 30
}
