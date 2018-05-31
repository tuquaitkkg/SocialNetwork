//
//  BaseResponse.swift
//  Svideo
//
//  Created by Pacific Ocean on 8/18/17.
//  Copyright © 2017 Minori. All rights reserved.
//

import Foundation
import EVReflection

class BaseResponse: EVObject,RequestProtocol {
    var code:NSNumber?
    var message:String = ""

}
