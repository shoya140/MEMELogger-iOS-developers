//
//  UIColor.swift
//  MEMELogger
//
//  Created by Shoya Ishimaru on 2015/12/31.
//  Copyright © 2015年 shoya140. All rights reserved.
//

import UIKit

extension UIColor {
    class func hex (code : NSString, alpha : CGFloat) -> UIColor {
        let code = code.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: code as String)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string")
            return UIColor.whiteColor();
        }
    }
}