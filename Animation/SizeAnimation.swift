//
//  SizeViewController.swift
//  AnimationDemo
//
//  Created by xww on 2019/4/25.
//  Copyright © 2019年 amberoot. All rights reserved.
//

import UIKit

class SizeViewController: UIViewController {

    @IBOutlet weak var imagView: UIImageView!
    
    @IBAction func btnReturnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    let viewForLayer = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let centerX = view.bounds.size.width/2
        let boundingRect = CGRect(x:centerX-80, y:50, width:160, height:160)
        let boundingRect2 = CGRect(x:0, y:0, width:80, height:80)
        viewForLayer.frame = boundingRect
        viewForLayer.backgroundColor = UIColor.blue
        view.addSubview(viewForLayer)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.6) {
            self.sizeAnimation()
            self.drawCircular(rect: boundingRect2)
//            self.drawCircular(rect: boundingRect2)
        }
        
    }
    
    func sizeAnimation() {
        let animation = CABasicAnimation(keyPath: "bounds.size")
        animation.fromValue = NSValue(cgSize: CGSize(width: 2.0, height: 2.0))
        animation.toValue = NSValue(cgSize: self.imagView.frame.size)
        animation.duration = 3
        animation.repeatCount = HUGE
        self.imagView.layer.add(animation, forKey: "Image-expend")
    }
    ///绘制空心圆形
    func drawCircular(rect: CGRect) {
        var orbitPath: CGPath!
        //通过CGPath的ellipseIn方法，创建一个圆形的CGPath
        orbitPath = CGPath(ellipseIn: rect, transform: nil)
        //绘制路线的图层
        drawPath(path: orbitPath)
//        performSizeAnimation(fromSize: rect.size, toSize: CGSize(width: 100, height: 100), duration: 3)
    }
    
    
    ///绘制路线的图层
    func drawPath(path: CGPath) {
        
        let circularPathLayer = CAShapeLayer()
        circularPathLayer.frame = viewForLayer.frame
        //pathLayer.isGeometryFlipped = true
        circularPathLayer.path = path
        circularPathLayer.fillColor = nil
        circularPathLayer.lineWidth = 3
        circularPathLayer.strokeColor = UIColor.white.cgColor
        view.layer.addSublayer(circularPathLayer)
        
    }
    
    func performSizeAnimation(fromSize: CGSize,toSize: CGSize, duration: CFTimeInterval,view: UIView) {
        //
        let animation = CABasicAnimation(keyPath: "bounds.size")
        animation.fromValue = NSValue(cgSize: fromSize)
        animation.toValue = NSValue(cgSize: toSize)
        animation.duration = duration
        animation.repeatCount = HUGE
        view.layer.add(animation, forKey: "Image-expend")
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
