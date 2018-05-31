//
//  Extension.swift
//  SecretSanta
//
//  Created by DAO VAN UOC on 11/25/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    static func getIndentifer<T:UITableViewCell>(returningClass: T.Type) -> String {
        return String(describing: T.classForCoder())
    }
    static func getIdentifier() -> String {
        return String(describing: self)
    }
}
extension UICollectionReusableView {
    static func getIdentifier() -> String {
        return String(describing: self)
    }
}

extension UIColor {
    public convenience init(colorHex: UInt32, alpha: CGFloat = 1.0) {
        let red     = CGFloat((colorHex & 0xFF0000) >> 16) / 255.0
        let green   = CGFloat((colorHex & 0x00FF00) >> 8 ) / 255.0
        let blue    = CGFloat((colorHex & 0x0000FF)      ) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)        } else {
            return nil
        }
    }
}

extension UIView{
    func border(color: UIColor?, radius: CGFloat, width: CGFloat? = 0.5) {
        layer.borderColor = color?.cgColor
        layer.borderWidth = width!
        layer.cornerRadius = radius
        layer.shouldRasterize = false
        clipsToBounds = true
        layer.masksToBounds = true
    }
}

extension String{
    public var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension UIImage {
    func totData() -> Data {
        let data = self.png
        if data != nil{
            return data!
        }
        return self.jpeg!
    }
    var jpeg: Data? {
        return UIImageJPEGRepresentation(self, 1)   // QUALITY min = 0 / max = 1
    }
    var png: Data? {
        return UIImagePNGRepresentation(self)
    }
}
