//
//  AccountObject.swift
//  SocialAnalysis
//
//  Created by DAO VAN UOC on 12/9/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class AccountObject: NSObject {
    var name:String!
    var status:Bool?
    var icon:String!
    
    init(name:String,icon:String,status:Bool) {
        self.name=name
        self.status = status
        self.icon = icon
    }
}
