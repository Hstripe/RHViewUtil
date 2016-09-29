//
//  IPNDynamicLabelText.swift
//  IPNScanner
//
//  Created by 黄睿 on 2016/8/25.
//  Copyright © 2016年 iPayNow. All rights reserved.
//

import UIKit

protocol IPNTextEditDelegate {
    func textFieldBeginEdit<T>(sender:T)
    func textFieldEditing<T>(sender:T)
    func textFieldEndEdit<T>(sender:T)
    func textFieldEndEditOnExit<T>(sender:T)
}

class IPNDynamicLabelText: UIView {
    
    var text : NSString {
        get{
            if self.componentLength == 0 {
                return self.textField.text!
            }else{
                return ((self.textField.text)! as NSString).stringByReplacingOccurrencesOfString(" ", withString: "")
            }
        }
    }
    
    var textField = UITextField()
    
    var textLength : NSInteger {
        get{
            if self.componentLength == 0 {
                return (self.textField.text?.characters.count)!
            }else{
                let str : NSString = ((self.textField.text)! as NSString).stringByReplacingOccurrencesOfString(" ", withString: "")
                return str.length
            }
        }
    }
    
    var label = UILabel()
    var maxlength : NSInteger = 0
    var componentLength : NSInteger? = 0
    var secureTextEntry : Bool = false
    var textColor : UIColor?
    var keyboardType : UIKeyboardType? = UIKeyboardType.Default
    var returnKeyType : UIReturnKeyType? = UIReturnKeyType.Default
    var placeHolder : String = ""
    var delegate : IPNTextEditDelegate?
    
    var viewMask : UIView?
    var isEditing : Bool?
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let tap = UITapGestureRecognizer.init(target: self, action: Selector(refresh()))
        self.addGestureRecognizer(tap);
        
        let frame : CGRect = self.bounds
        
        let label = UILabel.init(frame: CGRectMake(15, 28, 200, 15))
        label.font = UIFont.systemFontOfSize(13)
        label.text = self.placeHolder
        label.textColor = kLabelColor
        self.addSubview(label)
        self.label = label
        
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
        
        textView.addTarget(self, action: Selector(noHappy()), forControlEvents: UIControlEvents.EditingDidBegin)
        textView.addTarget(self, action: Selector(textFieldEditing()), forControlEvents: UIControlEvents.EditingChanged)
        textView.addTarget(self, action: Selector(textFieldEndEdit()), forControlEvents: UIControlEvents.EditingDidEnd)
        textView.addTarget(self, action: Selector(textFieldEndEditOnExit()), forControlEvents: UIControlEvents.EditingDidEndOnExit)
        
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
    
    func tapEvent<T>(sender:T){
        if self.isEditing == false {
            self.textField.becomeFirstResponder()
        }else{
            self.textFieldEndEdit();
        }
    }
    
//    func textViewDidBeginEditing(textView: UITextView) {
//        self.isEditing = true
//        self.setIsEditing(true)
//        self.delegate?.textFieldBeginEdit(self)
//        
//        let foregroundView = UIView.init(frame: CGRectMake(15, 26, self.bounds.size.width-50, 15))
//        foregroundView.backgroundColor = UIColor.clearColor()
//        foregroundView.userInteractionEnabled = true;
//        self.addSubview(foregroundView)
//        self.viewMask = foregroundView
//    }
    
    func  noHappy() {
        self.isEditing = true
        self.setIsEditing(true)
        self.delegate?.textFieldBeginEdit(self)
        
        let foregroundView = UIView.init(frame: CGRectMake(15, 26, self.bounds.size.width-50, 15))
        foregroundView.backgroundColor = UIColor.clearColor()
        foregroundView.userInteractionEnabled = true;
        self.addSubview(foregroundView)
        self.viewMask = foregroundView
    }
    
    
//    func textFieldBeginEdit<T>(sender: T){
//        self.isEditing = true
//        self.setIsEditing(true)
//        self.delegate?.textFieldBeginEdit(self)
//        
//        let foregroundView = UIView.init(frame: CGRectMake(15, 26, self.bounds.size.width-50, 15))
//        foregroundView.backgroundColor = UIColor.clearColor()
//        foregroundView.userInteractionEnabled = true;
//        self.addSubview(foregroundView)
//        self.viewMask = foregroundView
//    }
    
    func textFieldEditing<T>(sender:T) {
        //self.textProcessing()
        self.delegate?.textFieldEditing(self)
    }
    
    func textFieldEndEdit<T>(sender:T){
        self.delegate?.textFieldEndEdit(self)
    }
    
    func textFieldEndEditOnExit<T>(sender:T){
        self.delegate?.textFieldEndEditOnExit(self)
    }
    
    // 对textView中的输入进行文字处理
    func textProcessing() {
        
        var textFieldTxt = self.textField.text
        let txtLength = self.textField.text?.characters.count
        
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
    

     func setIsEditing(isEditing:Bool){
        let animationDuration = 0.30
        UIView.beginAnimations("MoveLabel", context: nil)
        UIView.setAnimationDuration(animationDuration)
        if isEditing == false {
            self.label.frame = CGRectMake(15, 28, 200, 15)
        }else{
            self.label.frame = CGRectMake(15, 5, 200, 15)
        }
        UIView.commitAnimations()
    }


    // 界面刷新，删掉蒙层，标签还原
    func refresh() {
        isEditing = false
        self.setIsEditing(false)
//        self.viewMask?.removeFromSuperview()
    
//        if (self.textField!.text?.isEmpty) != nil {
//
//        }
    }
    

}
