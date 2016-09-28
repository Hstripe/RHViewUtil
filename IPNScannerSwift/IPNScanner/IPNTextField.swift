//
//  IPNTextField.swift
//  IPNScanner
//
//  Created by 黄睿 on 2016/9/26.
//  Copyright © 2016年 iPayNow. All rights reserved.
//

import UIKit

class IPNTextField: UITextField {
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        let menuController = UIMenuController.sharedMenuController()
        if (menuController == true){
            UIMenuController.sharedMenuController().menuVisible = false
        }
        return false
    }

}
