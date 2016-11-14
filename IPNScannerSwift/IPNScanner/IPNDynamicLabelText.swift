//
//  IPNDynamicLabelText.swift
//  IPNScanner
//
//  Created by 黄睿 on 2016/8/25.
//  Copyright © 2016年 iPayNow. All rights reserved.
//

import UIKit

protocol IPNTextEditDelegate: class {
    func textFieldBeginEdit(_ sender: AnyObject)
    func textFieldEditing(_ sender: AnyObject)
    func textFieldEndEdit(_ sender: AnyObject)
    func textFieldEndEditOnExit(_ sender: AnyObject)
}

class IPNDynamicLabelText: UIView {
    
    var text : String {
        get{
            if componentLength == 0 {
                return textField!.text!
            }else{
                return textField!.text!.replacingOccurrences(of: " ", with: "")
            }
        }
    }
    
    var textField: UITextField?
    
    var textLength : NSInteger {
        get{
            if self.componentLength == 0 {
                return (textField!.text?.characters.count)!
            }else{
                let str = textField!.text!.replacingOccurrences(of: " ", with: "")
                return str.characters.count
            }
        }
    }
    
    var label: UILabel!
    var maxlength = 0
    var componentLength = 0
    var secureTextEntry = false
    var textColor: UIColor?
    var keyboardType = UIKeyboardType.default
    var returnKeyType = UIReturnKeyType.default
    var placeHolder : String = ""
    weak var delegate : IPNTextEditDelegate?
    
    var viewMask: UIView?
    var isEditing = false
    
    override func draw(_ rect: CGRect) {
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        if textField == nil {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapEvent(_:)))
            self.addGestureRecognizer(tap)
            
            let frame = bounds
            
            let label = UILabel(frame: CGRect(x: 15, y: 28, width: 200, height: 15))
            label.font = UIFont.systemFont(ofSize: 13)
            label.text = placeHolder
            label.textColor = kLabelTextColor
            self.addSubview(label)
            self.label = label
            
            let textView = IPNTextField(frame: CGRect(x: 15, y: 26, width: frame.size.width-30, height: 15))
            textView.textColor = textColor
            textView.font = UIFont.systemFont(ofSize: 14)
            if(textColor != nil){
                textView.textColor = textColor
            }else{
                textView.textColor = kWhiteColor
            }
            textView.isSecureTextEntry = secureTextEntry
            textView.clearButtonMode = UITextFieldViewMode.whileEditing
            textView.keyboardType = keyboardType
            textView.returnKeyType = returnKeyType
            
            textView.addTarget(self, action: #selector(textFieldBeginEdit(_:)), for: UIControlEvents.editingDidBegin)
            textView.addTarget(self, action: #selector(textFieldEditing(_:)), for: UIControlEvents.editingChanged)
            textView.addTarget(self, action: #selector(textFieldEndEdit(_:)), for: UIControlEvents.editingDidEnd)
            textView.addTarget(self, action: #selector(textFieldEndEditOnExit(_:)), for: UIControlEvents.editingDidEndOnExit)
            
            self.addSubview(textView)
            textField = textView
            
            let colorView = UIView(frame: CGRect(x: 15, y: 46, width: frame.size.width-30, height: 0.5))
            
            if textColor != nil {
                colorView.backgroundColor = self.textColor
            }else{
                colorView.backgroundColor = kWhiteColor
            }
            self.addSubview(colorView)
        }
    }
    
    // MARK: - TextFieldEvent
    
    func tapEvent(_ sender: AnyObject){
        if isEditing == false {
            textField!.becomeFirstResponder()
            print("false")
        }else{
            textField?.resignFirstResponder()
            refreshStatus()
            isEditing = false
            print("点击点击")

        }
    }
    
    func textFieldBeginEdit(_ sender: AnyObject){
        isEditing = true
        switchEditing(true)
        delegate?.textFieldBeginEdit(self)
        
        let foregroundView = UIView(frame: CGRect(x: 15, y: 26, width: self.bounds.size.width-50, height: 15))
        foregroundView.backgroundColor = UIColor.clear
        foregroundView.isUserInteractionEnabled = true;
        self.addSubview(foregroundView)
        viewMask = foregroundView
    }
    
    func textFieldEditing(_ sender: AnyObject) {
        textProcessing()
         delegate?.textFieldEditing(self)
    }
    
    func textFieldEndEdit(_ sender: AnyObject){
        refreshStatus()
        delegate?.textFieldEndEdit(self)
    }
    
    func textFieldEndEditOnExit(_ sender: AnyObject){
        delegate?.textFieldEndEditOnExit(self)
    }
    
    // 对textView中的输入进行文字处理
    func textProcessing() {
        
        var textFieldTxt = textField!.text
        let txtLength = textField!.text?.characters.count
        
        if componentLength == 0 {  // 无分割
            if maxlength > 0 && textLength > maxlength { // 默认键盘
                textFieldTxt = textFieldTxt!.substring(to: (textFieldTxt?.index((textFieldTxt?.startIndex)!, offsetBy: maxlength))!)
            }
        }else{
            let pureStr = textFieldTxt!.replacingOccurrences(of: " ", with: "")
            if pureStr.characters.count % componentLength == 1 && pureStr.characters.count > 1 && textFieldTxt![(textFieldTxt!.endIndex)] != " " {
                let str = pureStr.substring(from: pureStr.index(after: pureStr.startIndex))
                let cha = " \(str)"
                let result = (textFieldTxt! as NSString).replacingCharacters(in: NSRange(location: (textFieldTxt?.characters.count)!-1, length: 1), with: cha)
                textFieldTxt = result
            }
            
            if txtLength! > 0 {
                if textLength > maxlength {
                    textFieldTxt = (textFieldTxt! as NSString).replacingCharacters(in: NSMakeRange(txtLength! - 1, 1), with: "")
                }
                
                if (textFieldTxt! as NSString).substring(from: txtLength! - 1) == " " {
                    textFieldTxt = (textFieldTxt! as NSString).replacingCharacters(in: NSMakeRange(txtLength! - 1, 1), with: "")
                }
            }
        }
    }
    
     // Mark: - InstanceMethods
     func switchEditing(_ isEditing:Bool){
        let animationDuration = 0.30
        UIView.beginAnimations("MoveLabel", context: nil)
        UIView.setAnimationDuration(animationDuration)
        if isEditing == false {
            label.frame = CGRect(x: 15, y: 28, width: 200, height: 15)
        }else{
            label.frame = CGRect(x: 15, y: 5, width: 200, height: 15)
        }
        UIView.commitAnimations()
    }
    
    func hideKeyBoard(sender: AnyObject){
        self.delegate?.textFieldEndEdit(self)
    }


    // 界面刷新，删掉蒙层，标签还原
    func refreshStatus() {
        isEditing = false
        viewMask?.removeFromSuperview()
        
        if (textField!.text?.isEmpty)! {
            switchEditing(false)
        }
    }
    

}
