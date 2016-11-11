//
//  IPNDynamicButton.swift
//  IPNScanner
//
//  Created by 黄睿 on 2016/11/11.
//  Copyright © 2016年 iPayNow. All rights reserved.
//

import UIKit

class IPNDynamicButton: UIButton {
    
    var isWhiteBoard = false
    var shouldHideBoarder = false
   
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if self.shouldHideBoarder {
            self.setTitleColor(kLabelColor, for: .disabled)
            self.setTitleColor(kActiveColor, for: .normal)
        } else {
            if self.isWhiteBoard {
                self.setTitleColor(kWhiteColor, for: .disabled)
            } else {
                 self.setTitleColor(kLabelColor, for: .disabled)
            }
            self.setTitleColor(UIColor.white, for: .normal)
            self.layer.cornerRadius = 2
            self.layer.masksToBounds = true
        }
    }
    
    override var isEnabled: Bool {
        set{
            super.isEnabled = newValue
            if !self.shouldHideBoarder {
                if self.isEnabled == true {
                    self.backgroundColor = kActiveColor
                    self.layer.borderColor = UIColor.clear.cgColor
                    self.layer.borderWidth = 0.0
                } else {
                    self.layer.borderWidth = 0.5
                    self.backgroundColor = UIColor.clear
                    if self.isWhiteBoard {
                        self.layer.borderColor = kWhiteColor.cgColor
                    } else {
                        self.layer.borderColor = kButtonBorderColor.cgColor
                    }
                }
                self.setNeedsDisplay()
            } else {
                self.backgroundColor = UIColor.clear
            }
        }
        get{
            return super.isEnabled
        }
    }
    
}
