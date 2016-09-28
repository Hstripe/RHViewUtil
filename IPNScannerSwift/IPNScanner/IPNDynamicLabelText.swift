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
                return self.textField!.text!
            }else{
                return ((self.textField?.text)! as NSString).stringByReplacingOccurrencesOfString(" ", withString: "")
            }
        }
    }
    
    var textField : UITextField?
    
    var textLength : NSInteger {
        get{
            if self.componentLength == 0 {
                return (self.textField!.text?.characters.count)!
            }else{
                let str : NSString = ((self.textField?.text)! as NSString).stringByReplacingOccurrencesOfString(" ", withString: "")
                return str.length
            }

        }
    }
    
    var label:UILabel?
    var maxlength : NSInteger = 0
    var componentLength : NSInteger = 0
    var secureTextEntry : Bool = false
    var textColor : UIColor?
    var keyboardType : UIKeyboardType?
    var returnKeyType : UIReturnKeyType?
    var placeHolder : String = ""
    let delegate : IPNTextEditDelegate? = nil
    
    var MyLabel : UILabel?
    var viewMask : UIView?
    var isEditing : Bool?
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.textField == false {
        let tap = UITapGestureRecognizer.init(target: self, action: Selector(refresh()))
        self.addGestureRecognizer(tap);
        
        let frame : CGRect = self.bounds
        let textView : IPNTextField = IPNTextField.init(frame: CGRectMake(15, 26, frame.size.width-30, 15))
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
        
        textView.addTarget(self, action: Selector(textFieldBeginEdit()), forControlEvents: UIControlEvents.EditingDidBegin)
        textView.addTarget(self, action: Selector(textFieldEditing()), forControlEvents: UIControlEvents.EditingChanged)
        textView.addTarget(self, action: Selector(textFieldEndEdit()), forControlEvents: UIControlEvents.EditingDidEnd)
        textView.addTarget(self, action: Selector(textFieldEndEditOnExit()), forControlEvents: UIControlEvents.EditingDidEndOnExit)
        
        self.addSubview(textView)
        self.textField = textView
        
        let label = UILabel.init(frame: CGRectMake(15, 28, 200, 15))
        label.font = UIFont.systemFontOfSize(13)
        label.text = self.placeHolder
        label.textColor = kLabelColor
        self.addSubview(label)
        self.label = label
        
        let colorView = UIView.init(frame: CGRectMake(15, 46, frame.size.width-30, 0.5))
        if self.textColor == true {
            colorView.backgroundColor = self.textColor
        }else{
            colorView.backgroundColor = kWhiteColor
        }
        self.addSubview(colorView)
        }
    }
    
    func tapEvent<T>(sender:T){
        if self.isEditing == false {
            self.textField?.becomeFirstResponder()
        }else{
            self.textFieldEndEdit();
        }
    }
    
    func textFieldBeginEdit<T>(sender:T){
        self.isEditing = true
        self.setIsEditing(true)
        self.delegate?.textFieldBeginEdit(self)
        
        let foregroundView = UIView.init(frame: CGRectMake(15, 26, self.bounds.size.width-50, 15))
        foregroundView.backgroundColor = UIColor.clearColor()
        foregroundView.userInteractionEnabled = true;
        self.addSubview(foregroundView)
        self.viewMask = foregroundView
    }
    
    func textFieldEditing<T>(sender:T) {
        
        
    }
    
    func textFieldEndEdit<T>(sender:T){
        self.delegate?.textFieldEndEdit(self)
    }
    
    func textFieldEndEditOnExit<T>(sender:T){
        self.delegate?.textFieldEndEditOnExit(self)
    }
    
    // 对textView中的输入进行文字处理
    func textProcessing() {
        if self.componentLength == 0 {
            if self.maxlength > 0 && self.textLength > self.maxlength {
                self.textField?.text = (((self.textField?.text)! as NSString).substringToIndex(self.maxlength) as String)
            }else{
                let pureStr : NSString = ((self.textField?.text)! as NSString).stringByReplacingOccurrencesOfString(" ", withString: "")
                
                if pureStr.length % self.componentLength == 1 && pureStr.length > 1 && self.textField?.text![(self.textField?.text!.endIndex)!] != " " {
                    let str = " \(pureStr.substringFromIndex(pureStr.length - 1))"
                    self.textField?.text = ((self.textField?.text)! as NSString).stringByReplacingCharactersInRange(NSMakeRange((self.textField?.text!.characters.count)! - 1, 1), withString: str)
                }
                
                if self.textField!.text?.characters.count > 0 {
                    if self.textLength > self.maxlength {
                        
                    }
                }
                
            
            }
        }
    }
    
    
    func setIsEditing(isEditing:Bool){
        let animationDuration = 0.3
        UIView.beginAnimations("MoveLabel", context: nil)
        UIView.setAnimationDuration(animationDuration)
        if isEditing == false {
            self.label?.frame = CGRectMake(15, 28, 200, 15)
        }else{
            self.label?.frame = CGRectMake(15, 5, 200, 15)
        }
        UIView.commitAnimations()
    }


    // 界面刷新，删掉蒙层，标签还原
    func refresh() {
        isEditing = false
        self.viewMask?.removeFromSuperview()
    
        if (self.textField!.text?.isEmpty == true) {
            self.setIsEditing(false)
        }
    }
    

}
