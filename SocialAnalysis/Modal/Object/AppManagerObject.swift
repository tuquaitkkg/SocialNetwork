//
//  AppManagerObject.swift
//  SocialAnalysis
//
//  Created by DAO VAN UOC on 12/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class AppManagerObject: NSObject {
    var name:String!
    var color:String!
    var icon:String!
    var url:String!
    
    init(name:String,icon:String,color:String,url:String) {
        self.name=name
        self.color = color
        self.icon = icon
        self.url = url
    }
}
