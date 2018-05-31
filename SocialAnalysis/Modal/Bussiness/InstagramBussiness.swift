//
//  InstagramBussiness.swift
//  SocialAnalysis
//
//  Created by DAO VAN UOC on 12/16/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class InstagramBussiness: NSObject {
    // Singleton Instance
    class var sharedInstance: InstagramBussiness {
        struct Static {
            static let instance = InstagramBussiness()
        }
        return Static.instance
    }
    
    func requestMyFollow(userID:String, accessToken:String, success:DataCallBackSuccess, error:DataCallBackError) -> Void {
        let url = String.init(format: API.API_INSTAGRAM_MY_FOLLOW, accessToken)
        NetworkUtils.sharedInstance.getRequest(url, headers: nil, success: { (response) in
            print(response)
        }) { (error) in
            print(error)
        }
        
    }

}
