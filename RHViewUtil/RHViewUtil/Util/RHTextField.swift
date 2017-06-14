//
//  RHTextField.swift
//  RHViewUtil
//
//  Created by 黄睿 on 2017/6/14.
//  Copyright © 2017年 Doliant. All rights reserved.
//

import UIKit

class RHTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        let menuController: UIMenuController? = UIMenuController.shared
        if let menuController = menuController {
            menuController.isMenuVisible = false
        }
        return false
    }
}
