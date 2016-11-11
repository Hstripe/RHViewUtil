//
//  RHTextField.swift
//  IPNScanner
//
//  Created by 黄睿 on 16/10/2.
//  Copyright © 2016年 iPayNow. All rights reserved.
//

import UIKit

<<<<<<< HEAD:IPNScannerSwift/IPNScanner/IPNTextField.swift
class IPNTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        let menuController: UIMenuController? = UIMenuController.shared
        if menuController != nil {
            UIMenuController.shared.isMenuVisible = false
=======
class RHTextField: UITextField {
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        let menuController = UIMenuController.sharedMenuController()
        if (menuController == true){
            UIMenuController.sharedMenuController().menuVisible = false
>>>>>>> 6c9e7bf6b3ab7cbff639b1367a7aba20828ab4a0:IPNScannerSwift/IPNScanner/RHTextField.swift
        }
        return false
    }


}
