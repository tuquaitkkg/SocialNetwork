//
//  RequestProtocol.swift
//  Svideo
//
//  Created by DAO VAN UOC on 9/25/17.
//  Copyright © 2017 Minori. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    func toDict() -> [String: Any]
}

extension RequestProtocol{
    func toDict() -> [String: Any]
    {
        return Mirror(reflecting: self).toDictionary()
        
    }
}

extension Mirror {
    
    func toDictionary() -> [String: Any] {
        var dict = [String: Any]()
        
        // Properties of this instance:
        for attr in self.children {
            if let propertyName = attr.label {
                dict[propertyName] = attr.value
            }
        }
        
        // Add properties of superclass:
        if let parent = self.superclassMirror {
            for (propertyName, value) in parent.toDictionary() {
                dict[propertyName] = value
            }
        }
        
        return dict
    }
}
