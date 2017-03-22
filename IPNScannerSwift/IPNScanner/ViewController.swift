//
//  ViewController.swift
//  IPNScanner
//
//  Created by 黄睿 on 2016/8/24.
//  Copyright © 2016年 iPayNow. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate,IPNTextEditDelegate {
    
    
    @IBOutlet weak var textFieldTest: IPNDynamicLabelText!
    
    @IBOutlet weak var textFieldPassword: IPNDynamicLabelText!
    
    @IBOutlet weak var dynamicButton: IPNDynamicButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldTest.delegate = self
        textFieldTest.maxlength = 20
        textFieldTest.returnKeyType = UIReturnKeyType.next
        textFieldTest.placeHolder = "用户名"
    
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
       

    }
    
    
    func justDoIt() {

    }
    
    
    func textFieldBeginEdit(_ sender: AnyObject) {
        
    }
    
    func textFieldEndEdit(_ sender: AnyObject) {
     //self.textFieldTest.resignFirstResponder()
     self.textFieldPassword.becomeFirstResponder()
    }
    
    func textFieldEditing(_ sender: AnyObject) {
        if textFieldTest.textLength>0 && textFieldPassword.textLength>8 {
            dynamicButton.isEnabled = true
        } else {
            dynamicButton.isEnabled = false
        }
    }
    
    func textFieldEndEditOnExit(_ sender: AnyObject) {
        if textFieldTest.textField == (sender as! NSObject) {
            self.textFieldPassword.becomeFirstResponder()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }

}

