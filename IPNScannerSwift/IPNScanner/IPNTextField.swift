//
//  IPNTextField.swift
//  IPNScanner
//
//  Created by 黄睿 on 2016/9/26.
//  Copyright © 2016年 iPayNow. All rights reserved.
//

import UIKit

class IPNTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        let menuController: UIMenuController? = UIMenuController.shared
        if menuController != nil {
            UIMenuController.shared.isMenuVisible = false
        }
        return false
    }

}
