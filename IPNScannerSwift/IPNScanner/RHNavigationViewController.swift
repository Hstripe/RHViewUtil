//
//  RHNavigationViewController.swift
//  NavigationPop
//
//  Created by 黄睿 on 2016/11/14.
//  Copyright © 2016年 Ryan.Huang. All rights reserved.
//

import UIKit

class RHNavigationViewController: UINavigationController,UIGestureRecognizerDelegate {
    
    let defaultAlphy = 0.7
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    var forbiddenGestureArray: [String] = []
    var screenShotImageView: UIImageView!
    var coverView: UIView!
    var screenShotImageArray: [UIImage] = []
    var panGesture: UIPanGestureRecognizer!
    var gestureEnable: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.isEnabled = false // 要使用手势pop一定要先禁用掉Navigation的pop手势
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRec(_:)))
        view.addGestureRecognizer(panGesture)
        
        screenShotImageView = UIImageView()
        screenShotImageView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        coverView = UIView()
        coverView.frame = screenShotImageView!.frame
        coverView.backgroundColor = UIColor.black
    
    }
    
    // MARK: - 手势
    func panGestureRec(_ panGesture: UIPanGestureRecognizer) {
        if visibleViewController == viewControllers[0] {
            return
        }
        
        switch panGesture.state {
        case .began:
            dragBegin()
        case .ended:
            dragEnd()
        default:
            dragging(pan: panGesture)
        }
    }
    
    func dragBegin() {
        view.window?.insertSubview(screenShotImageView, at: 0)
        view.window?.insertSubview(coverView, aboveSubview:  screenShotImageView)
        screenShotImageView.image = screenShotImageArray.last
    }
    
    func dragEnd() {
    
        let translateX = view.transform.tx
        let width = view.frame.size.width
        // 滑动不够的时候
        if translateX <= ceil(screenWidth / 3) {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.transform = CGAffineTransform.identity // 清空view的偏移量。
                self.screenShotImageView.transform = CGAffineTransform(translationX: -self.screenWidth, y: 0)
                self.coverView.alpha = CGFloat(self.defaultAlphy)
            }, completion: { (Bool) in
                self.screenShotImageView.removeFromSuperview()
                self.coverView.removeFromSuperview()
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.transform = CGAffineTransform(translationX: width, y: 0)
                self.screenShotImageView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.coverView.alpha = 0.0
            }, completion: { (Bool) in
                // 记得清空view的transform,否则下次出现的时候位置不对
                self.view.transform = CGAffineTransform.identity
                self.screenShotImageView.removeFromSuperview()
                self.coverView.removeFromSuperview()
                self.popViewController(animated: false)
            })
        }
    }
    
    func dragging(pan: UIPanGestureRecognizer) {
        let offSet = pan.translation(in: view).x
        //print(offSet)
        if offSet > 0 {
            view.transform = CGAffineTransform(translationX: offSet, y: 0)
        }
        
        // 偏移量与屏幕宽度的比例，用来设定coverView的Alphy。
        let currentTranslateScaleX = offSet / screenWidth
        
        if offSet < screenWidth {
            screenShotImageView.transform = CGAffineTransform(translationX: (offSet - screenWidth) * 0.6 , y: 0)
        }
        let alpha = defaultAlphy - Double(currentTranslateScaleX) * defaultAlphy
        coverView.alpha = CGFloat(alpha)
    }
    
    // MARK: - 截图
    func screenShot() {
        let beyondVC = view.window?.rootViewController
        let size = beyondVC?.view.frame.size
        UIGraphicsBeginImageContextWithOptions(size!, true, 0.0)
        let rect = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        beyondVC?.view.drawHierarchy(in: rect, afterScreenUpdates: false)
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        
        if snapshot != nil {
            screenShotImageArray.append(snapshot!)
        }
        
        UIGraphicsEndImageContext()
    }
    
    // MARK: - 重写父类
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    
        gestureEnable = true
        for name in forbiddenGestureArray { // 判断是否为禁用手势的VC，若是就禁用手势。
            let className = String(describing: type(of: viewController))
            if className == name {
                gestureEnable = false
            }
        }
        
        panGesture?.isEnabled = gestureEnable

        if viewControllers.count >= 1 { // 当push的视图大于等于一个的时候才截图。
            screenShot()
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let count = viewControllers.count
        var className = ""
        if count >= 2 {
            className = String(describing: type(of: viewControllers[count - 2]))
        }
        
        gestureEnable = true
        for name in forbiddenGestureArray {
            if className == name {
                gestureEnable = false
            }
        }
        panGesture.isEnabled = gestureEnable
        
        screenShotImageArray.removeLast()
        return super.popViewController(animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        screenShotImageArray.removeAll()
        return super.popToRootViewController(animated: animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        gestureEnable = true
        for i in 0...viewControllers.count-1 {
            if viewController == viewControllers[i] {
                for name in forbiddenGestureArray {
                    if name == String(describing: type(of :viewController)) {
                        gestureEnable = false
                    }
                }
               screenShotImageArray.removeSubrange(i..<screenShotImageArray.count)
            }
           
        }
        panGesture.isEnabled = gestureEnable
        return super.popToViewController(viewController, animated: animated)
    }
}


















