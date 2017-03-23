//
//  ViewController.swift
//  IPNScanner
//
//  Created by 黄睿 on 2016/8/24.
//  Copyright © 2016年 iPayNow. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate,IPNTextEditDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var textFieldUserName: IPNDynamicTextField!
    
    @IBOutlet weak var textFieldPassword: IPNDynamicTextField!
    
    @IBOutlet weak var dynamicButton: IPNDynamicButton!
    
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
        
        let rhView = RHBubbleView.init(point: CGPoint(x: 50,y :50), diameter: 50, withContainView: view)
        rhView.bubbleColor = UIColor.blue
        rhView.bubbleTitle = "11"
        rhView.bubbleCoffient = 20
        rhView.setUp()
       
        let textField = UITextField(frame: CGRect(x: 10, y: 10, width: 30, height: 80))
        view.addSubview(textField)

    }
    
    
    
    
    func textFieldBeginEdit(_ textField: IPNDynamicTextField) {
        print("begin")
    }
    
    func textFieldEndEdit(_ textField: IPNDynamicTextField) {
    }
    
    func textFieldEditing(_ textField: IPNDynamicTextField) {
        if textFieldUserName.textLength>0 && textFieldPassword.textLength>8 {
            dynamicButton.isEnabled = true
        } else {
            dynamicButton.isEnabled = false
        }
    }
    
    func textFieldEndEditOnExit(_ textField: IPNDynamicTextField) {
        print("exite")
        if textField == textFieldUserName {
            textFieldPassword.becomeFirstResponder()
        }

    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }

}

