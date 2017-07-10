//
// Created by 黄睿 on 2017/7/10.
// Copyright (c) 2017 Doliant. All rights reserved.
//

import UIKit

typealias AddView = UIViewController
extension AddView {
    func add(colorView withRect: CGRect, backgroundColor: UIColor) -> UIView {
        let colorView = UIView(frame: withRect)
        colorView.backgroundColor = backgroundColor
        view.addSubview(colorView)
        return colorView
    }

    func add(colorView withRect: CGRect, backgroundColor: UIColor, onView view: UIView) -> UIView {
        let colorView = UIView(frame: withRect)
        colorView.backgroundColor = backgroundColor
        view.addSubview(colorView)
        return colorView
    }

    func add(imageView withRect: CGRect, imageName: String) -> UIImageView {
        let imageView = UIImageView(frame: withRect)
        imageView.image = UIImage(named: imageName)
        view.addSubview(imageView)
        return imageView
    }

    func add(imageView withRect: CGRect, imageName: String, onView view: UIView) -> UIImageView {
        let imageView = UIImageView(frame: withRect)
        imageView.image = UIImage(named: imageName)
        view.addSubview(imageView)
        return imageView
    }

     func add(shadowView withRect: CGRect, on view: UIView) -> UIView {
        let shadowView = UIView(frame: withRect)
        shadowView.backgroundColor = UIColor(red: 245 / 255.0, green: 247 / 255.0, blue: 249 / 255.0, alpha: 1.0)
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.5
        view.addSubview(shadowView)
        return shadowView
    }
}

typealias AddLabel = UIViewController
extension  AddLabel {
    func add(label withRect: CGRect,
             text: String,
             textAlignment: NSTextAlignment,
             fontSize: CGFloat,
             textColor: UIColor,
             backgroudColor: UIColor) -> UILabel {
        let label = UILabel(frame: withRect)
        label.text = text
        label.textAlignment = textAlignment
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = textColor
        label.backgroundColor = backgroudColor
        view.addSubview(label)
        return label
    }


    func add(label withRect: CGRect,
             text: String,
             textAlignment: NSTextAlignment,
             fontSize: CGFloat,
             textColor: UIColor,
             backgroudColor: UIColor,
             on view: UIView) -> UILabel {
        let label = UILabel(frame: withRect)
        label.text = text
        label.textAlignment = textAlignment
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = textColor
        label.backgroundColor = backgroudColor
        view.addSubview(label)
        return label
    }
}


typealias AddButton = UIViewController
extension AddButton {
    func add(button withRect: CGRect, Sel: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = withRect
        button.addTarget(self, action: Sel, for: .touchUpInside)
        view.addSubview(button)
        return button
    }

    func add(button withRect: CGRect, Sel: Selector, on view: UIView) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = withRect
        button.addTarget(self, action: Sel, for: .touchUpInside)
        view.addSubview(button)
        return button
    }

    func add(button withRect: CGRect, Sel: Selector, title: String, backgroundColor: UIColor) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = withRect
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.addTarget(self, action: Sel, for: .touchUpInside)
        view.addSubview(button)
        return button
    }

    func add(button withRect: CGRect,
                         Sel: Selector,
                       title: String,
             backgroundColor: UIColor,
                     on View: UIView) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = withRect
        button.addTarget(self, action: Sel, for: .touchUpInside)
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        view.addSubview(button)
        return button
    }
}

typealias AddTextField = UIViewController
extension AddTextField {
    func add(textField withRect: CGRect,
                    placeHolder: String,
                   isSecureText: Bool,
                   keyboardType: UIKeyboardType,
                  returnKeyType: UIReturnKeyType,
                       beginSel: Selector,
                        editSel: Selector,
                        exitSel: Selector) -> UITextField {
        let textField = UITextField(frame: withRect)
        textField.placeholder = placeHolder
        textField.isSecureTextEntry = isSecureText
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        textField.addTarget(self, action: beginSel, for: .editingDidBegin)
        textField.addTarget(self, action: editSel, for: .editingChanged)
        textField.addTarget(self, action: exitSel, for: .editingDidEndOnExit)
        view.addSubview(textField)
        return textField
    }

    func add(textField withRect: CGRect,
                    placeHolder: String,
                   isSecureText: Bool,
                   keyboardType: UIKeyboardType,
                  returnKeyType: UIReturnKeyType,
                       beginSel: Selector,
                        editSel: Selector,
                        exitSel: Selector,
                        on view: UIView) -> UITextField {
        let textField = UITextField(frame: withRect)
        textField.placeholder = placeHolder
        textField.isSecureTextEntry = isSecureText
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        textField.addTarget(self, action: beginSel, for: .editingDidBegin)
        textField.addTarget(self, action: editSel, for: .editingChanged)
        textField.addTarget(self, action: exitSel, for: .editingDidEndOnExit)
        view.addSubview(textField)
        return textField
    }

}

