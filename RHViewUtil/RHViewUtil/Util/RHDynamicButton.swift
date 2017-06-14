//
//  RHDynamicButton.swift
//  RHViewUtil
//
//  Created by 黄睿 on 2017/6/14.
//  Copyright © 2017年 Doliant. All rights reserved.
//

import UIKit

class RHDynamicButton: UIButton {
    var isWhiteBoard = false
    var shouldHideBoarder = false
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if shouldHideBoarder {
            setTitleColor(kLabelColor, for: .disabled)
            setTitleColor(kActiveColor, for: .normal)
        } else {
            if isWhiteBoard {
                setTitleColor(kWhiteColor, for: .disabled)
            } else {
                setTitleColor(kLabelColor, for: .disabled)
            }
            setTitleColor(UIColor.white, for: .normal)
            layer.cornerRadius = 2
            layer.masksToBounds = true
        }
    }
    
    override var isEnabled: Bool {
        set{
            super.isEnabled = newValue
            if !shouldHideBoarder {
                if isEnabled == true {
                    backgroundColor = kActiveColor
                    layer.borderColor = UIColor.clear.cgColor
                    layer.borderWidth = 0.0
                } else {
                    layer.borderWidth = 0.5
                    backgroundColor = UIColor.clear
                    if isWhiteBoard {
                        layer.borderColor = kWhiteColor.cgColor
                    } else {
                        layer.borderColor = kButtonBorderColor.cgColor
                    }
                }
                setNeedsDisplay()
            } else {
                backgroundColor = UIColor.clear
            }
        }
        get{
            return super.isEnabled
        }
    }

}
