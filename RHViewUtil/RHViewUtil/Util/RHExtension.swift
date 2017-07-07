//
//  RHExtension.swift
//  RHViewUtil
//
//  Created by 黄睿 on 2017/6/14.
//  Copyright © 2017年 Doliant. All rights reserved.
//

import UIKit

extension UIColor {
    // 十六进制色度转换
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

extension UIViewController {
    func add(colorView withRect: CGRect, backgroundColor: UIColor) -> UIView {
        let colorView = UIView(frame: withRect)
        colorView.backgroundColor = backgroundColor
        view.addSubview(colorView)
        return colorView
    }

    func add(colorView withRect: CGRect, backgroundColor: UIColor, onView view: UIView) -> UIView {
        let colorView = UIView(frame: withRect)
        colorView.backgroundColor = backgroundColor
        view.addSubview(colorView)
        return colorView
    }

    func add(imageView withRect: CGRect, imageName: String) -> UIImageView {
        let imageView = UIImageView(frame: withRect)
        imageView.image = UIImage(named: imageName)
        view.addSubview(imageView)
        return imageView
    }

    func add(imageView withRect: CGRect, imageName: String, onView view: UIView) -> UIImageView {
        let imageView = UIImageView(frame: withRect)
        imageView.image = UIImage(named: imageName)
        view.addSubview(imageView)
        return imageView
    }

    func add(label withRect: CGRect,
                       text: NSString,
              textAlignment: NSTextAlignment,
                   fontSize: CGFloat,
                  textColor: UIColor,
             backgroudColor: UIColor) -> UILabel {
        let label = UILabel(frame: withRect)
        label.text = text
        label.textAlignment = textAlignment
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = textColor
        label.backgroundColor = backgroudColor
        view.addSubview(label)
        return label
    }


    func add(label withRect: CGRect,
                       text: NSString,
              textAlignment: NSTextAlignment,
                   fontSize: CGFloat,
                  textColor: UIColor,
             backgroudColor: UIColor,
                    on view: UIView) -> UILabel {
        let label = UILabel(frame: withRect)
        label.text = text
        label.textAlignment = textAlignment
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = textColor
        label.backgroundColor = backgroudColor
        view.addSubview(label)
        return label
    }

}