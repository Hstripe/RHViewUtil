//
//  RHDynamicLoginText.swift
//  IPNScanner
//
//  Created by 黄睿 on 16/10/2.
//  Copyright © 2016年 iPayNow. All rights reserved.
//

import UIKit

<<<<<<< HEAD:IPNScannerSwift/IPNScanner/IPNDynamicLabelText.swift
protocol IPNTextEditDelegate: class {
    func textFieldBeginEdit(_ sender: AnyObject)
    func textFieldEditing(_ sender: AnyObject)
    func textFieldEndEdit(_ sender: AnyObject)
    func textFieldEndEditOnExit(_ sender: AnyObject)
}

class IPNDynamicLabelText: UIView {
=======
protocol RHTextEditDelegate {
    func textFieldBeginEdit(sender: AnyObject)
    func textFieldEditing(sender: AnyObject)
    func textFieldEndEdit(sender: AnyObject)
    func textFieldEndEditOnExit(sender: AnyObject)
}



class RHDynamicLoginText: UIView {
>>>>>>> 6c9e7bf6b3ab7cbff639b1367a7aba20828ab4a0:IPNScannerSwift/IPNScanner/RHDynamicLoginText.swift
    
    var text : String {
        get{
            if self.componentLength == 0 {
                return self.textField!.text!
            }else{
                return self.textField!.text!.replacingOccurrences(of: " ", with: "")
            }
        }
    }
    
    var textField: UITextField?
    
    var textLength : NSInteger {
        get{
            if self.componentLength == 0 {
                return (self.textField!.text?.characters.count)!
            }else{
                let str = self.textField!.text!.replacingOccurrences(of: " ", with: "")
                return str.characters.count
            }
        }
    }
    
    var label = UILabel()
<<<<<<< HEAD:IPNScannerSwift/IPNScanner/IPNDynamicLabelText.swift
    var maxlength = 0
    var componentLength = 0
    var secureTextEntry = false
=======
    var maxlength : NSInteger = 0
    var componentLength : NSInteger? = 0
    var secureTextEntry : Bool = false
>>>>>>> 6c9e7bf6b3ab7cbff639b1367a7aba20828ab4a0:IPNScannerSwift/IPNScanner/RHDynamicLoginText.swift
    var textColor : UIColor?
    var keyboardType = UIKeyboardType.default
    var returnKeyType = UIReturnKeyType.default
    var placeHolder : String = ""
<<<<<<< HEAD:IPNScannerSwift/IPNScanner/IPNDynamicLabelText.swift
    weak var delegate : IPNTextEditDelegate?
    
    var viewMask = UIView()
    var isEditing = false
    
    
    override func draw(_ rect: CGRect) {
        
    }
=======
    var delegate : RHTextEditDelegate?
    
    var viewMask : UIView?
    var isEditing : Bool = false
>>>>>>> 6c9e7bf6b3ab7cbff639b1367a7aba20828ab4a0:IPNScannerSwift/IPNScanner/RHDynamicLoginText.swift
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.textField == nil {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapEvent(_:)))
            self.addGestureRecognizer(tap)
            
            let frame = self.bounds
            
<<<<<<< HEAD:IPNScannerSwift/IPNScanner/IPNDynamicLabelText.swift
            let label = UILabel(frame: CGRect(x: 15, y: 28, width: 200, height: 15))
            label.font = UIFont.systemFont(ofSize: 13)
            label.text = self.placeHolder
            label.textColor = kLabelTextColor
            self.addSubview(label)
            self.label = label
            
            let textView = IPNTextField(frame: CGRect(x: 15, y: 26, width: frame.size.width-30, height: 15))
=======
            let label = UILabel.init(frame: CGRectMake(15, 28, 200, 15))
            label.font = UIFont.systemFontOfSize(13)
            label.text = self.placeHolder
            label.textColor = kLabelColor
            self.addSubview(label)
            self.label = label
            
            let textView = RHTextField.init(frame: CGRectMake(15, 26, frame.size.width-30, 15))
>>>>>>> 6c9e7bf6b3ab7cbff639b1367a7aba20828ab4a0:IPNScannerSwift/IPNScanner/RHDynamicLoginText.swift
            textView.textColor = self.textColor
            textView.font = UIFont.systemFont(ofSize: 14)
            if(self.textColor != nil){
                textView.textColor = self.textColor
            }else{
                textView.textColor = kWhiteColor
            }
            textView.isSecureTextEntry = self.secureTextEntry
            textView.clearButtonMode = UITextFieldViewMode.whileEditing
            textView.keyboardType = self.keyboardType
            textView.returnKeyType = self.returnKeyType
            
            textView.addTarget(self, action: #selector(textFieldBeginEdit(_:)), for: UIControlEvents.editingDidBegin)
            textView.addTarget(self, action: #selector(textFieldEditing(_:)), for: UIControlEvents.editingChanged)
            textView.addTarget(self, action: #selector(textFieldEndEdit(_:)), for: UIControlEvents.editingDidEnd)
            textView.addTarget(self, action: #selector(textFieldEndEditOnExit(_:)), for: UIControlEvents.editingDidEndOnExit)
            
            self.addSubview(textView)
            self.textField = textView
            
            let colorView = UIView(frame: CGRect(x: 15, y: 46, width: frame.size.width-30, height: 0.5))
            
            if self.textColor != nil {
                colorView.backgroundColor = self.textColor
            }else{
                colorView.backgroundColor = kWhiteColor
            }
            self.addSubview(colorView)
        }
    }
    
<<<<<<< HEAD:IPNScannerSwift/IPNScanner/IPNDynamicLabelText.swift
    // MARK: - TextFieldEvent
    
    func tapEvent(_ sender: AnyObject){
=======
    func tapEvent(sender: AnyObject){
>>>>>>> 6c9e7bf6b3ab7cbff639b1367a7aba20828ab4a0:IPNScannerSwift/IPNScanner/RHDynamicLoginText.swift
        if self.isEditing == false {
            self.textField!.becomeFirstResponder()
        }else{
            self.textField?.resignFirstResponder()
<<<<<<< HEAD:IPNScannerSwift/IPNScanner/IPNDynamicLabelText.swift
            self.refreshStatus()
            self.isEditing = false
            print("点击点击")

        }
    }
    
    func textFieldBeginEdit(_ sender: AnyObject){
        self.isEditing = true
        self.switchEditing(true)
=======
            self.viewMask?.removeFromSuperview()
        }
    }
    
    func textFieldBeginEdit(sender: AnyObject){
        self.switchEditStaus()
>>>>>>> 6c9e7bf6b3ab7cbff639b1367a7aba20828ab4a0:IPNScannerSwift/IPNScanner/RHDynamicLoginText.swift
        self.delegate?.textFieldBeginEdit(self)
        
        let foregroundView = UIView(frame: CGRect(x: 15, y: 26, width: self.bounds.size.width-50, height: 15))
        foregroundView.backgroundColor = UIColor.clear
        foregroundView.isUserInteractionEnabled = true;
        self.addSubview(foregroundView)
        self.viewMask = foregroundView
    }
    
    func textFieldEditing(_ sender: AnyObject) {
        self.textProcessing()
        self.delegate?.textFieldEditing(self)
    }
    
<<<<<<< HEAD:IPNScannerSwift/IPNScanner/IPNDynamicLabelText.swift
    func textFieldEndEdit(_ sender: AnyObject){
        self.refreshStatus()
=======
    func textFieldEndEdit(sender: AnyObject){
        self.switchEditStaus()
>>>>>>> 6c9e7bf6b3ab7cbff639b1367a7aba20828ab4a0:IPNScannerSwift/IPNScanner/RHDynamicLoginText.swift
        self.delegate?.textFieldEndEdit(self)
        
    }
    
    func textFieldEndEditOnExit(_ sender: AnyObject){
        self.delegate?.textFieldEndEditOnExit(self)
    }
    
    
    /**
     输入内容处理
     */
    func textProcessing() {
        
        var textFieldTxt = self.textField!.text
        let txtLength = self.textField!.text?.characters.count
        
        if self.componentLength == 0 {  // 无分割
            if self.maxlength > 0 && self.textLength > self.maxlength { // 默认键盘
<<<<<<< HEAD:IPNScannerSwift/IPNScanner/IPNDynamicLabelText.swift
                textFieldTxt = textFieldTxt!.substring(to: (textFieldTxt?.index((textFieldTxt?.startIndex)!, offsetBy: self.maxlength))!)
            }
        }else{
            let pureStr = textFieldTxt!.replacingOccurrences(of: " ", with: "")
            if pureStr.characters.count % self.componentLength == 1 && pureStr.characters.count > 1 && textFieldTxt![(textFieldTxt!.endIndex)] != " " {
                let str = pureStr.substring(from: pureStr.index(after: pureStr.startIndex))
                let cha = " \(str)"
                let result = (textFieldTxt! as NSString).replacingCharacters(in: NSRange(location: (textFieldTxt?.characters.count)!-1, length: 1), with: cha)
                textFieldTxt = result
            }
            
            if txtLength! > 0 {
                if self.textLength > self.maxlength {
                    textFieldTxt = (textFieldTxt! as NSString).replacingCharacters(in: NSMakeRange(txtLength! - 1, 1), with: "")
=======
                textFieldTxt = ((textFieldTxt! as NSString).substringToIndex(self.maxlength) as String)
                
            }else{
                let pureStr : NSString = (textFieldTxt! as NSString).stringByReplacingOccurrencesOfString(" ", withString: "")
                
                if pureStr.length % self.componentLength! == 1 && pureStr.length > 1 && textFieldTxt![(textFieldTxt!.endIndex)] != " " {
                    let str = " \(pureStr.substringFromIndex(pureStr.length - 1))"
                    textFieldTxt = (textFieldTxt! as NSString).stringByReplacingCharactersInRange(NSMakeRange(txtLength! - 1, 1), withString: str)
>>>>>>> 6c9e7bf6b3ab7cbff639b1367a7aba20828ab4a0:IPNScannerSwift/IPNScanner/RHDynamicLoginText.swift
                }
                
                if (textFieldTxt! as NSString).substring(from: txtLength! - 1) == " " {
                    textFieldTxt = (textFieldTxt! as NSString).replacingCharacters(in: NSMakeRange(txtLength! - 1, 1), with: "")
                }
            }
        }
    }
    
<<<<<<< HEAD:IPNScannerSwift/IPNScanner/IPNDynamicLabelText.swift
     // Mark: - InstanceMethods
     func switchEditing(_ isEditing:Bool){
        let animationDuration = 0.30
        UIView.beginAnimations("MoveLabel", context: nil)
        UIView.setAnimationDuration(animationDuration)
        if isEditing == false {
            self.label.frame = CGRect(x: 15, y: 28, width: 200, height: 15)
        }else{
            self.label.frame = CGRect(x: 15, y: 5, width: 200, height: 15)
        }
        UIView.commitAnimations()
    }
    
    func hideKeyBoard(sender: AnyObject){
        self.delegate?.textFieldEndEdit(self)
    }


    // 界面刷新，删掉蒙层，标签还原
    func refreshStatus() {
        self.isEditing = false
        self.viewMask.removeFromSuperview()
        
        if (self.textField!.text?.isEmpty)! {
            self.switchEditing(false)
        }
    }
=======
    /**
     编辑状态切换
     */
    func switchEditStaus() {
        let switchStatus = self.textField?.text?.isEmpty
        let annimationDuration = 0.30
        UIView.beginAnimations("moveLabel", context: nil)
        UIView.setAnimationDuration(annimationDuration)
        self.isEditing = !self.isEditing
        
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
>>>>>>> 6c9e7bf6b3ab7cbff639b1367a7aba20828ab4a0:IPNScannerSwift/IPNScanner/RHDynamicLoginText.swift
    
}
