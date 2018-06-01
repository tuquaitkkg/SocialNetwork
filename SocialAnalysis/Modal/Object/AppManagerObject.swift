//
//  AppManagerObject.swift
//  SocialAnalysis
//
//  Created by DAO VAN UOC on 12/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class AppManagerObject: NSObject,NSCoding {
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
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let color = aDecoder.decodeObject(forKey: "color") as! String
        let icon = aDecoder.decodeObject(forKey: "icon") as! String
        let url = aDecoder.decodeObject(forKey: "url") as! String
        self.init(name: String(name), icon: String(icon), color: String(color), url: String(url))
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(color, forKey: "color")
        aCoder.encode(icon, forKey: "icon")
        aCoder.encode(url, forKey: "url")
    }
}

class Favorites: NSObject,NSCoding {
    var array:[AppManagerObject]!
    
    init(array:[AppManagerObject]) {
        self.array = array
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let array = aDecoder.decodeObject(forKey: "arrFavorite")
        self.init(array: array as! [AppManagerObject])
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(array, forKey: "arrFavorite")
        
    }
    
    func save() {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self)
        userDefaults.set(encodedData, forKey: "favorite")
        userDefaults.synchronize()
    }
}
