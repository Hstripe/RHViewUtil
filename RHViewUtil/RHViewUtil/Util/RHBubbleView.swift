//
//  RHBubbleView.swift
//
//
//  Created by 黄睿 on 2016/11/18.
//  Copyright © 2016年 iPayNow. All rights reserved.
//

import UIKit

class RHBubbleView: UIView {
    
    
    var bubbleColor: UIColor? = UIColor.white // 气泡颜色
    var bubbleTitle: String? = ""     // 气泡的文字
    var bubbleCoffient: CGFloat = 1.0 // 气泡可拉长的系数
    
    private var bubbleDiameter: CGFloat = 0.0
    private var bubbleRadius: CGFloat = 0.0
    private var originalX: CGFloat = 0.0
    private var originalY: CGFloat = 0.0
    private var originalBackViewframe: CGRect!
    // 贝塞尔绘图用点
    private var pointA = CGPoint(x: 0.0, y: 0.0)
    private var pointB = CGPoint(x: 0.0, y: 0.0)
    private var controlPoint = CGPoint(x: 0.0, y: 0.0)
    private var pointC = CGPoint(x: 0.0, y: 0.0)
    private var pointD = CGPoint(x: 0.0, y: 0.0)
    
    private var containView: UIView!
    private var bezierPath: UIBezierPath!
    private var frontView: UIView!
    private var backView: UIView!
    private var shapeLayer: CAShapeLayer!
    private var bubbleLabel: UILabel!
    
    // 气泡的坐标，直径，父视图
    init(point: CGPoint, diameter: CGFloat, withContainView containView: UIView) {
        super.init(frame: CGRect(x: point.x, y: point.y, width: diameter, height: diameter))
        originalX = point.x
        originalY = point.y
        bubbleDiameter = diameter
        bubbleRadius = bubbleDiameter / 2
        containView.addSubview(self)
        self.containView = containView
        isUserInteractionEnabled = true
        
    }
    
       
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   func setUp() {
        shapeLayer = CAShapeLayer()
        backgroundColor = UIColor.clear
        frontView = UIView(frame: CGRect(x: originalX, y: originalY, width: bubbleDiameter, height: bubbleDiameter))
        frontView.layer.cornerRadius = bubbleRadius
        frontView.backgroundColor = bubbleColor
        
        backView = UIView(frame: frontView.frame)
        backView.layer.cornerRadius = bubbleRadius
        backView.backgroundColor = bubbleColor
        
        originalBackViewframe = backView.frame
        
        let bubbleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frontView.bounds.size.width, height: frontView.bounds.size.height))
        bubbleLabel.text = bubbleTitle
        bubbleLabel.textColor = UIColor.white
        bubbleLabel.textAlignment = .center
        self.bubbleLabel = bubbleLabel
        frontView.addSubview(self.bubbleLabel)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handleDrageGesture(_:)))
        frontView.addGestureRecognizer(pan)
    
        containView.addSubview(backView)
        containView.addSubview(frontView)
    }

   @objc private func handleDrageGesture(_ ges: UIPanGestureRecognizer) {
        let dragPoint = ges.location(in: containView)
        switch ges.state {
        case .began:
            backView.isHidden = false
        case .changed:
            frontView.center = dragPoint
            if bubbleRadius <= 10 {
                backView.isHidden = true
                shapeLayer.fillColor = UIColor.clear.cgColor
                shapeLayer.removeFromSuperlayer()
            }
            figureOutCoordinateAndDisplay()
        default:
            if bubbleRadius <= 10 {
                backView.isHidden = true
                shapeLayer.fillColor = UIColor.clear.cgColor
                shapeLayer.removeFromSuperlayer()
                frontView.isHidden = true
            } else if bubbleRadius > 10 && bubbleRadius <= 15 {
                UIView.animate(withDuration: 1.8,
                               delay: 0.0,
                               usingSpringWithDamping: 0.4,
                               initialSpringVelocity: 0.0,
                               options: .curveEaseInOut,
                               animations: {
                                self.backView.center = dragPoint
                                self.frontView.center = dragPoint
                                self.shapeLayer.fillColor = UIColor.clear.cgColor
                                self.shapeLayer.removeFromSuperlayer()
                                self.backView.isHidden = true
                                self.backView.frame = self.originalBackViewframe
                                self.bubbleDiameter = self.originalBackViewframe.size.width
                                self.bubbleRadius = self.bubbleDiameter / 2
                                self.setNeedsDisplay() 
                                
                })
            } else {
                UIView.animate(withDuration: 1.8,
                               delay: 0.0,
                               usingSpringWithDamping: 0.4,
                               initialSpringVelocity: 0.0,
                               options: .curveEaseInOut,
                               animations: {
                                self.backToOriginal()
                                self.setNeedsDisplay()
                })
            }

            
        }
    }
    
    // 还原值
  private func backToOriginal() {
        backView.isHidden = true
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.removeFromSuperlayer()
        frontView.frame = originalBackViewframe
        bubbleDiameter = originalBackViewframe.size.width
        bubbleRadius = bubbleDiameter / 2
    }

    // 计算坐标并展示
    private func figureOutCoordinateAndDisplay() {
        let x1 = backView.center.x
        let y1 = backView.center.y
        let x2 = frontView.center.x
        let y2 = frontView.center.y
        let centerDistance = sqrt(pow((x2 - x1), 2) + pow((y2 - y1), 2))
        bubbleDiameter = originalBackViewframe.size.width - centerDistance / bubbleCoffient
        bubbleRadius = bubbleDiameter / 2
        let cosDigree = (y2 - y1) / centerDistance
        let sinDigree = (x2 - x1) / centerDistance

        pointA = CGPoint(x: x1 - bubbleRadius * cosDigree, y: y1 + bubbleRadius * sinDigree)
        pointB = CGPoint(x: x1 + bubbleRadius * cosDigree, y: y1 - bubbleRadius * sinDigree)
        pointC = CGPoint(x: x2 + bubbleRadius * cosDigree, y: y2 - bubbleRadius * sinDigree)
        pointD = CGPoint(x: x2 - bubbleRadius * cosDigree, y: y2 + bubbleRadius * sinDigree)
        controlPoint = CGPoint(x: (x2 - x1) / 2 + x1, y: (y2 - y1) / 2 + y1)
        
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        backView.bounds = CGRect(x: 0, y: 0, width: bubbleDiameter, height: bubbleDiameter)
        backView.layer.cornerRadius = bubbleRadius
        frontView.bounds = CGRect(x: 0, y: 0, width: bubbleDiameter, height: bubbleDiameter)
        frontView.layer.cornerRadius = bubbleRadius
        bubbleLabel.frame = CGRect(x: 0, y: 0, width: frontView.bounds.width, height: frontView.bounds.height)
        
        bezierPath = UIBezierPath()
        bezierPath.move(to: pointA)
        bezierPath.addQuadCurve(to: pointD, controlPoint: controlPoint)
        bezierPath.addLine(to: pointC)
        bezierPath.addQuadCurve(to: pointB, controlPoint: controlPoint)
        bezierPath.move(to: pointA)
        
        if backView.isHidden != true {
            shapeLayer.path = bezierPath.cgPath
            shapeLayer.fillColor = bubbleColor?.cgColor
            containView.layer.insertSublayer(shapeLayer, below: frontView.layer)
        }
    }

}


