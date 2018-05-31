//
//  SettingObject.swift
//  SecretSanta
//
//  Created by DAO VAN UOC on 11/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class SettingObject: NSObject {
    var name:String!
    var value:Bool?
    var content:String!
    
    init(name:String,content:String,value:Bool) {
        self.name=name
        self.value = value
        self.content = content
    }
}
