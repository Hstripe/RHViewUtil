//
//  ViewController.swift
//  RHViewUtil
//
//  Created by 黄睿 on 2017/6/14.
//  Copyright © 2017年 Doliant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldUserName: RHDynamicTextField!
    @IBOutlet weak var textFieldPassword: RHDynamicTextField!
    @IBOutlet weak var dynamicButton: RHDynamicButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldUserName.delegate = self
        textFieldUserName.maxlength = 20
        textFieldUserName.returnKeyType = UIReturnKeyType.next
        textFieldUserName.placeHolder = "用户名"
        
        textFieldPassword.delegate = self
        textFieldPassword.maxlength = 20
        textFieldPassword.returnKeyType = UIReturnKeyType.done
        textFieldPassword.placeHolder = "密码"
        textFieldPassword.secureTextEntry = true
        dynamicButton.isEnabled = false
        view.isUserInteractionEnabled = true






    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

private typealias TextFieldDelegate = ViewController
extension TextFieldDelegate: RHTextEditDelegate {
    func textFieldBeginEdit(_ textField: RHDynamicTextField) {
        print("begin Edit")
    }
    
    func textFieldEditing(_ textField: RHDynamicTextField) {
        if textFieldUserName.textLength>0 && textFieldPassword.textLength>8 {
            dynamicButton.isEnabled = true
        } else {
            dynamicButton.isEnabled = false
        }
    }
    
    func textFieldEndEdit(_ textField: RHDynamicTextField) {
    }
    
    func textFieldEndEditOnExit(_ textField: RHDynamicTextField) {
        print("exite")
        if textField == textFieldUserName {
            textFieldPassword.becomeFirstResponder()
        }
    }
    
    
}


