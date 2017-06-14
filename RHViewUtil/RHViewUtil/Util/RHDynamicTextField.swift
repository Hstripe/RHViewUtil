//
//  RHDynamicTextField.swift
//  RHViewUtil
//
//  Created by 黄睿 on 2017/6/14.
//  Copyright © 2017年 Doliant. All rights reserved.
//

import UIKit
protocol RHTextEditDelegate: class {
    func textFieldBeginEdit(_ textField: RHDynamicTextField)
    func textFieldEditing(_ textField: RHDynamicTextField)
    func textFieldEndEdit(_ textField: RHDynamicTextField)
    func textFieldEndEditOnExit(_ textField: RHDynamicTextField)
}

@IBDesignable
class RHDynamicTextField: UIView {

    private var text : String {
        if componentLength == 0 {
            return textField!.text!
        }else{
            return textField!.text!.replacingOccurrences(of: " ", with: "")
        }
    }
    private var componentLength = 0
    private var label: UILabel!
    private var viewMask: UIView?
    private var isEditing = false
    
    private var textField: UITextField?
    /** 文字长度 **/
    public var textLength : NSInteger {
        if componentLength == 0 {
            return (textField!.text?.characters.count)!
        }else{
            let str = textField!.text!.replacingOccurrences(of: " ", with: "")
            return str.characters.count
        }
    }
    /** 最大输入长度 **/
    public var maxlength = 0
    /** 密文输入 **/
    public var secureTextEntry = false
    /** 文字颜色 **/
    public var textColor: UIColor?
    /** 键盘类型 **/
    public var keyboardType = UIKeyboardType.default
    /** 返回键类型 **/
    public var returnKeyType = UIReturnKeyType.default
    /** 占位文字 **/
    public var placeHolder: String = ""
    /** 占位文字颜色 **/
    public var placeHolderColor: UIColor = kLabelColor
    /** 占位文字弹起颜色 **/
    public var placeHolderUpColor: UIColor = kLabelColor
    /** 下划线颜色 **/
    public var lineColor: UIColor?
    public weak var delegate : RHTextEditDelegate?
    
    override func draw(_ rect: CGRect) {
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if textField == nil {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapEvent(_:)))
            addGestureRecognizer(tap)
            
            let label = UILabel(frame: CGRect(x: 15, y: 28, width: 200, height: 15))
            label.font = UIFont.systemFont(ofSize: 13)
            label.text = placeHolder
            label.textColor = placeHolderColor
            addSubview(label)
            self.label = label
            
            let textView = RHTextField(frame: CGRect(x: 15, y: 26, width: frame.size.width-30, height: 15))
            textView.font = UIFont.systemFont(ofSize: 14)
            if let textColor = textColor {
                textView.textColor = textColor
            }else{
                textView.textColor = kWhiteColor
            }
            textView.isSecureTextEntry = secureTextEntry
            textView.clearButtonMode = UITextFieldViewMode.whileEditing
            textView.keyboardType = keyboardType
            textView.returnKeyType = returnKeyType
            
            textView.addTarget(self, action: #selector(beginEdit(_:)), for: UIControlEvents.editingDidBegin)
            textView.addTarget(self, action: #selector(editing(_:)), for: UIControlEvents.editingChanged)
            textView.addTarget(self, action: #selector(endEdit(_:)), for: UIControlEvents.editingDidEnd)
            textView.addTarget(self, action: #selector(endEditOnExit(_:)), for: UIControlEvents.editingDidEndOnExit)
            
            addSubview(textView)
            textField = textView
            
            let colorView = UIView(frame: CGRect(x: 15, y: 46, width: frame.size.width-30, height: 0.5))
            
            if let lineColor = lineColor {
                colorView.backgroundColor = lineColor
            } else if let textColor = textColor {
                colorView.backgroundColor = textColor
            } else {
                colorView.backgroundColor = kLabelColor
            }
            addSubview(colorView)
        }
    }
    
    // MARK: - TextFieldEvent
    
    @objc private func tapEvent(_ sender: AnyObject){
        if isEditing == false {
            textField!.becomeFirstResponder()
        }else{
            textField?.resignFirstResponder()
            refreshStatus()
        }
    }
    
    @objc private func beginEdit(_ sender: RHDynamicTextField){
        isEditing = true
        switchEditing(true)
        delegate?.textFieldBeginEdit(self)
        
        let foregroundView = UIView(frame: CGRect(x: 15, y: 26, width: self.bounds.size.width-50, height: 15))
        foregroundView.backgroundColor = UIColor.clear
        foregroundView.isUserInteractionEnabled = true;
        addSubview(foregroundView)
        viewMask = foregroundView
    }
    
    @objc private func editing(_ sender: RHDynamicTextField) {
        textProcessing()
        delegate?.textFieldEditing(self)
    }
    
    @objc private func endEdit(_ sender: RHDynamicTextField){
        refreshStatus()
        delegate?.textFieldEndEdit(self)
    }
    
    @objc private func endEditOnExit(_ sender: RHDynamicTextField){
        delegate?.textFieldEndEditOnExit(self)
    }
    
    // 对textView中的输入进行文字处理
    private func textProcessing() {
        
        var textFieldTxt = textField!.text
        let txtLength = textField!.text?.characters.count
        
        if componentLength == 0 {  // 无分割
            if maxlength > 0 && textLength > maxlength { // 默认键盘
                let index = textFieldTxt?.index((textFieldTxt?.startIndex)!, offsetBy: maxlength)
                textFieldTxt = textFieldTxt!.substring(to: index!)
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
    
    // MARK: - override Responder Method
    @discardableResult override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        return (self.textField?.becomeFirstResponder())!
    }
    
    @discardableResult override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        return (self.textField?.resignFirstResponder())!
    }
    
    
    
    // MARK: - InstanceMethods
    private func switchEditing(_ isEditing:Bool){
        let animationDuration = 0.50
        UIView.beginAnimations("MoveLabel", context: nil)
        UIView.setAnimationDuration(animationDuration)
        if isEditing == false {
            label.textColor = placeHolderColor
            label.frame = CGRect(x: 15, y: 28, width: 200, height: 15)
        }else{
            label.textColor = placeHolderUpColor
            label.frame = CGRect(x: 15, y: 5, width: 200, height: 15)
        }
        UIView.commitAnimations()
    }
    
    private func hideKeyBoard(_ sender: AnyObject){
        delegate?.textFieldEndEdit(self)
    }
    
    
    // 界面刷新，删掉蒙层，标签还原
    private func refreshStatus() {
        isEditing = false
        viewMask?.removeFromSuperview()
        
        if (textField!.text?.isEmpty)! {
            switchEditing(false)
        }
    }
    

}
