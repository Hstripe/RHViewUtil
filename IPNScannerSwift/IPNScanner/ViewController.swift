//
//  ViewController.swift
//  IPNScanner
//
//  Created by 黄睿 on 2016/8/24.
//  Copyright © 2016年 iPayNow. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate,RHTextEditDelegate {
    
    
    @IBOutlet weak var textFieldTest: RHDynamicLoginText!
    
    @IBOutlet weak var textFieldPassword: RHDynamicLoginText!
    
    @IBOutlet weak var dynamicButton: IPNDynamicButton!
    
    var scrollView = UIScrollView()
    var view1 = UIView()
    var view2 = UIView()
    var view3 = UIView()
    var width : CGFloat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        width = self.view.frame.size.width
        textFieldTest.delegate = self
        textFieldTest.maxlength = 20
        textFieldTest.returnKeyType = UIReturnKeyType.next
        textFieldTest.placeHolder = "用户名"
    
        textFieldPassword.delegate = self
        textFieldPassword.maxlength = 20
        textFieldPassword.returnKeyType = UIReturnKeyType.done
        textFieldPassword.placeHolder = "密码"
        textFieldPassword.secureTextEntry = true
<<<<<<< HEAD
        dynamicButton.isEnabled = false
        
=======
        
        // 添加手势退出编辑状态，不要能用touch方法替换，响应链传递机制会导致编辑状态错误
        let tapTouch = UITapGestureRecognizer.init(target: self, action: #selector(tapFunction))
        self.view.addGestureRecognizer(tapTouch)
    
    }
>>>>>>> 6c9e7bf6b3ab7cbff639b1367a7aba20828ab4a0
    
    func tapFunction() {
        self.view.endEditing(true)
    }
    
    func textFieldBeginEdit(_ sender: AnyObject) {
        
    }
    
<<<<<<< HEAD
    func textFieldEndEdit(_ sender: AnyObject) {
//        self.textFieldTest.resignFirstResponder()
////        self.textFieldTest = nil
=======
    func textFieldEndEdit(sender: AnyObject) {
        
>>>>>>> 6c9e7bf6b3ab7cbff639b1367a7aba20828ab4a0
    }
    
    func textFieldEditing(_ sender: AnyObject) {
        if textFieldTest.textLength>0 && textFieldPassword.textLength>8 {
            dynamicButton.isEnabled = true
        } else {
            dynamicButton.isEnabled = false
        }
    }
    
    func textFieldEndEditOnExit(_ sender: AnyObject) {
        if self.textFieldTest.textField == (sender as! NSObject) {
            self.textFieldPassword.becomeFirstResponder()
        }
    }
    
//    func createUI(){
//        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
//        scrollView.backgroundColor = UIColor.orange
//        scrollView.delegate = self
//        scrollView.contentSize = CGSize(width: self.view.frame.size.width * 3 , height: self.view.frame.size.height)
//        scrollView.isPagingEnabled = true
//        self.view.addSubview(scrollView)
//        self.view1 = UIView.init(frame: CGRect(x: 75, y: 222, width: 225, height: 222))
//        self.view1.backgroundColor = UIColor.black
//        self.view2 = UIView.init()
//        self.view2.frame = CGRect(x: 450, y: 222, width: 225, height: 222)
//        self.view2.backgroundColor = UIColor.blue
//        self.view3 = UIView.init(frame: CGRect(x: 825, y: 222, width: 225, height: 222))
//        self.view3.backgroundColor = UIColor.green
//        scrollView.addSubview(self.view1)
//        scrollView.addSubview(self.view2)
//        scrollView.addSubview(self.view3)
//        self.scrollView = scrollView
//    }
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        
//        let contentOffsetX = (self.scrollView.contentOffset.x)
//        
//        let transform1 = CGAffineTransform(rotationAngle: -0.5 * contentOffsetX / width!)
//        let transform2 = CGAffineTransform(rotationAngle: 0.5 - 0.5 * contentOffsetX / width!)
//        let transform3 = CGAffineTransform(rotationAngle: 1 - (0.5 * contentOffsetX / width!))
//        self.view1.transform = transform1.translatedBy(x: -contentOffsetX * 0.3, y: 75 * contentOffsetX / width!)
//        if contentOffsetX <= width!  {
//            self.view2.transform = transform2.translatedBy(x: -(contentOffsetX - width!) * 0.3, y: 75 - 75 * contentOffsetX / width!)
//        }else{
//            self.view2.transform = transform2.translatedBy(x: -(contentOffsetX - width!) * 0.3, y: 75 * (contentOffsetX - width!) / width!)
//        }
//            self.view3.transform = transform3.translatedBy(x: -(contentOffsetX - width! * 2) * 0.3, y: 150-75 * contentOffsetX / width!)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

<<<<<<< HEAD
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

=======
>>>>>>> 6c9e7bf6b3ab7cbff639b1367a7aba20828ab4a0
}

