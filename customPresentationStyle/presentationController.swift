//
//  presentationController.swift
//
//  Created by xww on 17/10/17.
//  Copyright © 2017年 amberoot. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {

    // 定义属性保存菜单的大小
    var presentFrame = CGRect.zero
    
    /// 初始化方法，用于创建负责转场动画的对象
    /// - parameter presentedViewController:  被展现的控制器
    /// - parameter presentingViewController: 发起的控制器
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        //print(presentedViewController)
        //print(presentingViewController!)
        
    }
    
    //即将布局转场子视图时调用
    override func containerViewWillLayoutSubviews()
    {
        //1.修改弹出视图的尺寸
        //containerView:容器视图； presentedView：即将显示视图
        if presentFrame == CGRect.zero
        {
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height
            presentedView?.frame = CGRect(x: screenWidth/2-200, y: screenHeight/2-300, width: 400, height: 220)
        }else
        {
            presentedView?.frame = presentFrame
        }
        //2.在容器视图上添加一个蒙板，插入到展现视图到下面
        //不能直接添加，会挡住视图
        //containerView?.addSubview(coverView)
        containerView?.insertSubview(coverView, at: 0)
    }
    
    //MARK: - 懒加载
    private lazy var coverView: UIView = {
        //1.创建view
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        view.frame = UIScreen.main.bounds
        //2.添加监听
        let tap = UITapGestureRecognizer(target: self, action: #selector(PopoverPresentationController.close))
        view.addGestureRecognizer(tap)
        return view
        
    }()
    
    func close()
    {
        //presentedViewController拿到当前弹出的控制器
        presentedViewController.dismiss(animated: true, completion: nil)
    }

}
