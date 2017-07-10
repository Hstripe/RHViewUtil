//
//  RHColorExtension.swift
//  RHViewUtil
//
//  Created by 黄睿 on 2017/6/14.
//  Copyright © 2017年 Doliant. All rights reserved.
//

import UIKit

typealias HexadecimalColor = UIColor
extension HexadecimalColor {
    class func hexColor(_ hexValue: UInt) -> UIColor {
        return UIColor(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
                     green: CGFloat((hexValue & 0xFF00) >> 8) / 255.0,
                      blue: CGFloat((hexValue & 0xFF)) / 255.0, alpha: 1.0)
    }

    class func hexColor(_ hexValue: UInt, withAlpha Alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
                     green: CGFloat((hexValue & 0xFF00) >> 8) / 255.0,
                      blue: CGFloat((hexValue & 0xFF)) / 255.0, alpha: Alpha)
    }
    
}































