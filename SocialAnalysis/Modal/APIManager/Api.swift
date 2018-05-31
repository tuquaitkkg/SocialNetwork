//
//  Api.swift
//  Svideo
//
//  Created by Pacific Ocean on 8/18/17.
//  Copyright © 2017 Minori. All rights reserved.
//

import Foundation
struct API {
    static let DOMAIN_INSTAGRAM             = "https://api.instagram.com/v1"
    static let API_INSTAGRAM_MY_FOLLOW      = "\(API.DOMAIN_INSTAGRAM)/users/%@/follows?access_token=%@"
    

}

struct RESPONSE_CODE {
    static let SUCCESS                      = 200
}
