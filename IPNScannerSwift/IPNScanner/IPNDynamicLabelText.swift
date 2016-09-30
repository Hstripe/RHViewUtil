//
//  IPNDynamicLabelText.swift
//  IPNScanner
//
//  Created by 黄睿 on 2016/8/25.
//  Copyright © 2016年 iPayNow. All rights reserved.
//

import UIKit

protocol IPNTextEditDelegate {
    func textFieldBeginEdit(sender: AnyObject)
    func textFieldEditing(sender: AnyObject)
    func textFieldEndEdit(sender: AnyObject)
    func textFieldEndEditOnExit(sender: AnyObject)
}



class IPNDynamicLabelText: UIView {
    
    var text : NSString {
        get{
            if self.componentLength == 0 {
                return self.textField!.text!
            }else{
                return ((self.textField!.text)! as NSString).stringByReplacingOccurrencesOfString(" ", withString: "")
            }
        }
    }
    
    var textField : UITextField? = nil
    
    var textLength : NSInteger {
        get{
            if self.componentLength == 0 {
                return (self.textField!.text?.characters.count)!
            }else{
                let str : NSString = ((self.textField!.text)! as NSString).stringByReplacingOccurrencesOfString(" ", withString: "")
                return str.length
            }
        }
    }
    
    var label = UILabel.init(frame: CGRectMake(15, 28, 200, 15))
    var maxlength : NSInteger = 0
    var componentLength : NSInteger? = 0
    var secureTextEntry : Bool = false
    var textColor : UIColor?
    var keyboardType : UIKeyboardType? = UIKeyboardType.Default
    var returnKeyType : UIReturnKeyType? = UIReturnKeyType.Default
    var placeHolder : String = ""
    var delegate : IPNTextEditDelegate?
    
    var viewMask : UIView?
    var isEditing : Bool = false
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.textField == nil {
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(_:)))
            self.addGestureRecognizer(tap)
            
            let frame : CGRect = self.bounds
            
            self.label.font = UIFont.systemFontOfSize(13)
            self.label.text = self.placeHolder
            self.label.textColor = kLabelTextColor
            self.addSubview(self.label)
            
            let textView = IPNTextField.init(frame: CGRectMake(15, 26, frame.size.width-30, 15))
            textView.textColor = self.textColor
            textView.font = UIFont.systemFontOfSize(14)
            if(self.textColor == true){
                textView.textColor = self.textColor
            }else{
                textView.textColor = kWhiteColor
            }
            textView.secureTextEntry = self.secureTextEntry
            textView.clearButtonMode = UITextFieldViewMode.WhileEditing
            textView.keyboardType = self.keyboardType!
            textView.returnKeyType = self.returnKeyType!
            
            textView.addTarget(self, action: #selector(textFieldBeginEdit(_:)), forControlEvents: UIControlEvents.EditingDidBegin)
            textView.addTarget(self, action: #selector(textFieldEditing(_:)), forControlEvents: UIControlEvents.EditingChanged)
            textView.addTarget(self, action: #selector(textFieldEndEdit(_:)), forControlEvents: UIControlEvents.EditingDidEnd)
            textView.addTarget(self, action: #selector(textFieldEndEditOnExit(_:)), forControlEvents: UIControlEvents.EditingDidEndOnExit)
            
            self.addSubview(textView)
            self.textField = textView
            
            let colorView = UIView.init(frame: CGRectMake(15, 46, frame.size.width-30, 0.5))
            
            if self.textColor == true {
                colorView.backgroundColor = self.textColor
            }else{
                colorView.backgroundColor = kWhiteColor
            }
            self.addSubview(colorView)
        }
    }
    
    func tapEvent(sender: AnyObject){
        if self.isEditing == false {
            self.textField!.becomeFirstResponder()
            
        }else{
            //self.textField?.resignFirstResponder()
            //self.refreshStatus()
            self.isEditing = false
//            print("点击点击")

        }
    }
    
    func textFieldBeginEdit(sender: AnyObject){
        self.isEditing = true
        self.switchEditStaus()
        self.delegate?.textFieldBeginEdit(self)
        
        let foregroundView = UIView.init(frame: CGRectMake(15, 26, self.bounds.size.width-50, 15))
        foregroundView.backgroundColor = UIColor.clearColor()
        foregroundView.userInteractionEnabled = true;
        self.addSubview(foregroundView)
        self.viewMask = foregroundView
    }
    
    func textFieldEditing(sender: AnyObject) {
        //self.textProcessing()
        self.delegate?.textFieldEditing(self)
    }
    
    func textFieldEndEdit(sender: AnyObject){
//        self.refreshStatus()
        self.isEditing = false
        self.switchEditStaus()
        self.isEditing = true
        self.delegate?.textFieldEndEdit(self)
        
    }
    
    func textFieldEndEditOnExit(sender: AnyObject){
        self.delegate?.textFieldEndEditOnExit(self)
    }
    
    // 对textView中的输入进行文字处理
    func textProcessing() {
        
        var textFieldTxt = self.textField!.text
        let txtLength = self.textField!.text?.characters.count
        
        if self.componentLength == 0 {  // 无分割
            if self.maxlength > 0 && self.textLength > self.maxlength { // 默认键盘
                textFieldTxt = ((textFieldTxt! as NSString).substringToIndex(self.maxlength) as String)
            
            }else{
                let pureStr : NSString = (textFieldTxt! as NSString).stringByReplacingOccurrencesOfString(" ", withString: "")
                
                if pureStr.length % self.componentLength! == 1 && pureStr.length > 1 && textFieldTxt![(textFieldTxt!.endIndex)] != " " {
                    let str = " \(pureStr.substringFromIndex(pureStr.length - 1))"
                    textFieldTxt = (textFieldTxt! as NSString).stringByReplacingCharactersInRange(NSMakeRange(txtLength! - 1, 1), withString: str)
                }
                
                if txtLength > 0 {
                    if self.textLength > self.maxlength {
                        textFieldTxt = (textFieldTxt! as NSString).stringByReplacingCharactersInRange(NSMakeRange(txtLength! - 1, 1), withString: "")
                    }
                    
                    if (textFieldTxt! as NSString).substringFromIndex(txtLength! - 1) == " " {
                        textFieldTxt = (textFieldTxt! as NSString).stringByReplacingCharactersInRange(NSMakeRange(txtLength! - 1, 1), withString: "")
                    }
                }
            }
        }
    }
    
    func switchEditStaus() {
        let switchStatus = self.textField?.text?.isEmpty
        let annimationDuration = 0.30
        UIView.beginAnimations("moveLabel", context: nil)
        UIView.setAnimationDuration(annimationDuration)
        
        if self.isEditing == true {
            self.label.frame = CGRectMake(15, 5, 200, 15)
        }else{
            if switchStatus == true {
                self.label.frame = CGRectMake(15, 28, 200, 15)
            }else{
                self.label.frame = CGRectMake(15, 5, 200, 15)
            }
        }
        UIView.commitAnimations()
    }

//     func switchEditing(isEditing:Bool){
//        let animationDuration = 0.30
//        UIView.beginAnimations("MoveLabel", context: nil)
//        UIView.setAnimationDuration(animationDuration)
//        if isEditing == false {
//            self.label.frame = CGRectMake(15, 28, 200, 15)
//        }else{
//            self.label.frame = CGRectMake(15, 5, 200, 15)
//        }
//        UIView.commitAnimations()
//    }


    // 界面刷新，删掉蒙层，标签还原
    func refreshStatus() {
        self.isEditing = false
        self.viewMask?.removeFromSuperview()
        
        self.switchEditStaus()
    }
    

}
