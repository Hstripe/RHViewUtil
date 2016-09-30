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
    
    
    var scrollView : UIScrollView?
    var view1 : UIView?
    var view2 : UIView?
    var view3 : UIView?
    var width : CGFloat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        width = self.view.frame.size.width
        textFieldTest.delegate = self
        textFieldTest.maxlength = 20
        textFieldTest.returnKeyType = UIReturnKeyType.Next
        textFieldTest.placeHolder = "用户名"
    
        textFieldPassword.delegate = self
        textFieldPassword.maxlength = 20
        textFieldPassword.returnKeyType = UIReturnKeyType.Done
        textFieldPassword.placeHolder = "密码"
        textFieldPassword.secureTextEntry = true
    
    }
    
    func textFieldBeginEdit(sender: AnyObject) {
        
    }
    
    func textFieldEndEdit(sender: AnyObject) {
//        self.textFieldTest.resignFirstResponder()
////        self.textFieldTest = nil
    }
    
    func textFieldEditing(sender: AnyObject) {
       
    }
    
    func textFieldEndEditOnExit(sender: AnyObject) {
        if self.textFieldTest.textField == sender as! NSObject {
            self.textFieldPassword.becomeFirstResponder()
        }
    }
    
    func createUI(){
        let scrollView = UIScrollView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        scrollView.backgroundColor = UIColor.orangeColor()
        scrollView.delegate = self
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 3 , self.view.frame.size.height)
        scrollView.pagingEnabled = true
        self.view.addSubview(scrollView)
        self.view1 = UIView.init(frame: CGRectMake(75, 222, 225, 222))
        self.view1!.backgroundColor = UIColor.blackColor()
        self.view2 = UIView.init()
        self.view2?.frame = CGRectMake(450, 222, 225, 222)
        self.view2?.backgroundColor = UIColor.blueColor()
        self.view3 = UIView.init(frame: CGRectMake(825, 222, 225, 222))
        self.view3?.backgroundColor = UIColor.greenColor()
        scrollView.addSubview(self.view1!)
        scrollView.addSubview(self.view2!)
        scrollView.addSubview(self.view3!)
        self.scrollView = scrollView
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let contentOffsetX = (self.scrollView?.contentOffset.x)!
        
        let transform1 = CGAffineTransformMakeRotation(-0.5 * contentOffsetX / width!)
        let transform2 = CGAffineTransformMakeRotation(0.5 - 0.5 * contentOffsetX / width!)
        let transform3 = CGAffineTransformMakeRotation(1 - (0.5 * contentOffsetX / width!))
        self.view1?.transform = CGAffineTransformTranslate(transform1, -contentOffsetX * 0.3, 75 * contentOffsetX / width!)
        if contentOffsetX <= width!  {
            self.view2?.transform = CGAffineTransformTranslate(transform2, -(contentOffsetX - width!) * 0.3, 75 - 75 * contentOffsetX / width!)
        }else{
            self.view2?.transform = CGAffineTransformTranslate(transform2, -(contentOffsetX - width!) * 0.3, 75 * (contentOffsetX - width!) / width!)
        }
            self.view3?.transform = CGAffineTransformTranslate(transform3, -(contentOffsetX - width! * 2) * 0.3, 150-75 * contentOffsetX / width!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}

