//
//  PathAnimationViewController.swift
//  AnimationDemo
//
//  Created by xww on 2019/4/24.
//  Copyright © 2019年 cuanbo. All rights reserved.
//

import UIKit

class PathAnimationViewController: UIViewController, CAAnimationDelegate {

    let square = UIView()
    
    @IBOutlet weak var btnReturn: UIButton!
    
    @IBAction func btnReturnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        square.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        square.backgroundColor = UIColor.blue
        view.addSubview(square)
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            self.MutablePathAnimation()
//        }
    }
    ///按照复制路径运动的动画
    func MutablePathAnimation() {
        let centerX = view.bounds.size.width/2
        let centerY = view.bounds.size.height/2
        //创建用于转移坐标的Transform，这样我们不用按照实际显示做坐标计算
        let transform = CGAffineTransform(translationX: centerX, y: centerY)
        let path =  CGMutablePath()

        path.addArc(center: CGPoint(x:0 ,y:75), radius: 75, startAngle: CGFloat(0.5 * .pi),endAngle: .pi, clockwise: false, transform: transform)
        //将view移动到脸部下巴
        path.move(to: CGPoint(x:0 ,y:150), transform: transform)
        path.addArc(center: CGPoint(x:0 ,y:75), radius: 75, startAngle: CGFloat(0.5 * .pi),endAngle: 0, clockwise: true, transform: transform)
        //将view移动到脸部中间
        path.move(to: CGPoint(x:0 ,y:100), transform: transform)
        path.addLine(to: CGPoint(x:-75 ,y:75), transform: transform)
        //将view移动到脸部中间
        path.move(to: CGPoint(x:0 ,y:100), transform: transform)
        path.addLine(to: CGPoint(x:75 ,y:75), transform: transform)
        
        //绘制路线的图层
        drawPath(path: path)
        //创建并执行动画
        performPathMoveAnimation(path: path)

    }
    
    ///按照圆形路径运动的动画
    func circularPathAnimation() {
        let centerX = view.bounds.size.width/2
        let boundingRect = CGRect(x:centerX-75, y:50, width:150, height:150)
        var circularPath: CGPath!
        //通过CGPath的ellipseIn方法，创建一个圆形的CGPath作为我们的关键帧动画的path。
        circularPath = CGPath(ellipseIn: boundingRect, transform: nil)
        //绘制路线的图层
        drawPath(path: circularPath)
        //创建并执行动画
        performPathMoveAnimation(path: circularPath)
        
    }
    ///实现移动路径动画
    func performPathMoveAnimation(path: CGPath) {
        let animation = CAKeyframeAnimation(keyPath:"position")
        animation.duration = 6
        animation.path = path
        //让Core Animation向被驱动的对象施加一个恒定速度，不管路径的各个线段有多长。
        animation.calculationMode = kCAAnimationPaced
        //让方块沿着路径旋转，即方块不管移动到哪个位置，它始终朝向圆心
        animation.rotationMode = kCAAnimationRotateAuto
        //让目标动画完成后停留在终点位置--method1
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        //让动画循环播放
        animation.repeatCount = HUGE
        animation.delegate = self
        //把动画添加到图层
        square.layer.add(animation,forKey:"Move")
        //让目标动画完成后停留在终点位置--method2
        //        square.layer.position = CGPoint(x:centerX+75, y:125)
        
        
    }
    
    ///实现关键帧动画
    func performPointMoveAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        //设置5个位置点
        let p1 = CGPoint(x: 10, y: 10)
        let p2 = CGPoint(x: 300, y: 10)
        let p3 = CGPoint(x: 300, y: 300)
        let p4 = CGPoint(x: 10, y: 300)
        let p5 = CGPoint(x: 150, y: 200)
        
        //赋值
        animation.values = [NSValue(cgPoint: p1), NSValue(cgPoint: p2), NSValue(cgPoint: p3), NSValue(cgPoint: p4), NSValue(cgPoint: p5)]
        
        //每个动作的时间百分比
        animation.keyTimes = [NSNumber(value: 0.0), NSNumber(value: 0.4), NSNumber(value: 0.6), NSNumber(value: 0.8), NSNumber(value: 1.0), ]
        
        animation.delegate = self
        animation.duration = 6.0
//        animation.repeatCount = HUGE
        
        square.layer.add(animation, forKey: "Image-Move")
    }
    
    ///绘制路线的图层
    func drawPath(path: CGPath) {
        
        let pathLayer = CAShapeLayer()
        pathLayer.frame = self.view.bounds
        //pathLayer.isGeometryFlipped = true
        pathLayer.path = path
        pathLayer.fillColor = nil
        pathLayer.lineWidth = 1
        pathLayer.strokeColor = UIColor.black.cgColor
        
        //给运动轨迹添加动画
        let pathAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        pathAnimation.duration = 3
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        //pathAnimation.delegate = (window as! CAAnimationDelegate)
        pathLayer.add(pathAnimation , forKey: "strokeEnd")
        
        self.view.layer.addSublayer(pathLayer)
    }

    func animationDidStart(_ anim: CAAnimation) {
        print("动画开始")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("动画结束")
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
