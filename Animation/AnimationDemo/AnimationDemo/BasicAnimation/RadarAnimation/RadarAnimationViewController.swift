//
//  RadarAnimationViewController.swift
//  AnimationDemo
//
//  Created by xww on 2019/4/25.
//  Copyright © 2019年 cuanbo. All rights reserved.
//

import UIKit

class RadarAnimationViewController: UIViewController {

    private let radarAnimation = "radarAnimation"
    
    private var animationLayer: CALayer?
    private var animationGroup: CAAnimationGroup?
    //
    private var animationLayerRound: CALayer?
    private var animationGroupRound: CAAnimationGroup?
    
    private var opBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        //圆形的雷达动画波纹
        let animationLayer1 = makeRadarAnimation(showRect: CGRect(x: 120, y: 100, width: 100, height: 100), isRound: true, isLine: true, color: UIColor.blue)
        view.layer.addSublayer(animationLayer1)
        
        ///把按钮添加到界面
        opBtn = UIButton(frame: CGRect(x: 100, y: 450, width: 80, height: 80))
        opBtn.backgroundColor = UIColor.red
        opBtn.clipsToBounds = true
        opBtn.setTitle("Hsu", for: .normal)
        opBtn.layer.cornerRadius = 10
        view.addSubview(opBtn)
        ///把按钮的动画层放到按钮下方
        let animationLayer2 = makeRadarAnimation(showRect: opBtn.frame, isRound: false, isLine: false, color: UIColor.orange)
        view.layer.insertSublayer(animationLayer2, below: opBtn.layer)
        
        ///1秒后启动动画
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            self.animationLayer?.add(self.animationGroup!, forKey: self.radarAnimation)
            self.animationLayerRound?.add(self.animationGroupRound!, forKey: "radarAnimationRound")
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        animationLayer?.removeAnimation(forKey: radarAnimation)
        animationLayer?.removeAllAnimations()
    }
    
    private func makeRadarAnimation(showRect: CGRect, isRound: Bool, isLine: Bool, color: UIColor) -> CALayer {
        // 1. 一个动态波
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = showRect
        // showRect 最大内切圆
        if isRound {
            shapeLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: showRect.width, height: showRect.height)).cgPath
        } else {
            // 矩形
            shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: showRect.width, height: showRect.height), cornerRadius: 10).cgPath
        }
        if isLine {
            shapeLayer.fillColor = nil
            shapeLayer.lineWidth = 3
            shapeLayer.strokeColor = color.cgColor
        }else {
            shapeLayer.fillColor = color.cgColor
        }
        // 默认初始颜色透明度
        shapeLayer.opacity = 0.0
        if isRound {
            animationLayerRound = shapeLayer
        }else {
            animationLayer = shapeLayer
        }
        // 2. 需要重复的动态波，即创建副本
        let replicator = CAReplicatorLayer()
        replicator.frame = shapeLayer.bounds
        replicator.instanceCount = 4
        replicator.instanceDelay = 1.0
        replicator.addSublayer(shapeLayer)
        
        // 3. 创建动画组
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = NSNumber(floatLiteral: 1.0)  // 开始透明度
        opacityAnimation.toValue = NSNumber(floatLiteral: 0)      // 结束时透明底
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform")
        if isRound {
            scaleAnimation.fromValue = NSValue.init(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0, 0, 0))      // 缩放起始大小
        } else {
            scaleAnimation.fromValue = NSValue.init(caTransform3D: CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0))      // 缩放起始大小
        }
        scaleAnimation.toValue = NSValue.init(caTransform3D: CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 0))      // 缩放结束大小
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [opacityAnimation, scaleAnimation]
        animationGroup.duration = 3.0       // 动画执行时间
        animationGroup.repeatCount = HUGE   // 最大重复
        animationGroup.autoreverses = false
        if isRound {
            self.animationGroupRound = animationGroup
        }else {
            self.animationGroup = animationGroup
        }
//        shapeLayer.add(animationGroup, forKey: radarAnimation)
//
        return replicator
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
