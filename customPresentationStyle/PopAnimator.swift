//
//  Animator.swift
//
//  Created by xww on 17/10/17.
//  Copyright © 2017年 amberoot. All rights reserved.
//

import UIKit

class PopAnimator: NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning
{
    private var isPresent = false
    // 定义属性保存菜单的大小
    var presentFrame = CGRect.zero
    
    //实现代理方法，告诉系统谁来负责转场动画
    //UIPresentationController专门用于转场动画（iOS8推出）
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        let pc = PopoverPresentationController(presentedViewController: presented, presenting: presenting)
        //设置菜单的大小
        pc.presentFrame = presentFrame
        
        
        return pc
    }
    
    
    //MARK: - UIViewControllerTransitioningDelegate必须实现以下两个方法，只要实现了以下两个方法，那么系统自带的默认动画就会没有，动画要程序员自己实现
    
    /// 告诉系统谁来负责modal的展现动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = true
        //发送通知：视图即将展开
//        NotificationCenter.default.post(name: Animator_Show, object: self)
        
        return self
    }
    
    /// 告诉系统谁来负责modal的消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = false
        //发送通知：视图即将关闭
//        NotificationCenter.default.post(name: PopoverAnimator_Dismiss, object: self)
        return self
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning协议的方法
    /// 返回动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 0.3
    }
    
    /// 告诉系统如果动画，无论动画的展现还是消失都会调用这个方法
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        // 1. 拿到展现视图
        //let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        //let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        //print(toVC!)//toVC：即将展示的视图控制器
        //print(fromVC!)//fromVC：之前展现的视图控制器
        if isPresent
        {
            // 即将显示的视图
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
            //折叠视图(按比例)：x轴不变，y轴压缩
            toView?.transform = CGAffineTransform.init(scaleX: 1.0, y: 0)
            // 将视图添加到容器上
            transitionContext.containerView.addSubview(toView!)
            // 设置錨点，让视图从上至下展现
            toView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            
            // 2. 执行动画
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                //2.1 清空transform
                toView?.transform = CGAffineTransform.identity
                
            }) { (_) in
                //2.2 动画执行完毕，一定要告诉系统
                transitionContext.completeTransition(true)
            }
        }else//关闭视图
        {
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                //由于CGFloat不准确，y写0.0会没有动画
                fromView?.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.0000001 )
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        }
        
    }
    
    
}

