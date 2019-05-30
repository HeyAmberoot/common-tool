//
//  ViewTool.swift
//  8BC
//
//  Created by xww on 2019/3/20.
//  Copyright © 2019年 cuanbo. All rights reserved.
//

import Foundation
import UIKit

class ViewTool {

    //单例设计，防止创建多个CommonFunc对象
    public static let sharedInstance: ViewTool = ViewTool()
    private let lan = LanguageHelper.shareInstance
    
    ///默认提示框
    func showAlertView(mes: String, controller: UIViewController) {
        
        let alertController:UIAlertController = UIAlertController(title: "系统提示", message: mes, preferredStyle: UIAlertControllerStyle.alert)
        let yesAction = UIAlertAction(title: "确定", style: .default) { (UIAlertAction) in
            // NSLog("tap yes button")
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(yesAction)
        controller.present(alertController, animated: true, completion: nil)
        //        controller.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        
    }
    
    ///短时提示框
    func showTipView(mes: String, controller: UIViewController) {
        let alertController = UIAlertController(title: mes,message: nil, preferredStyle: .alert)
        //显示提示框
        //        controller.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        controller.present(alertController, animated: true, completion: nil)
        //两秒钟后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.8){
            controller.presentedViewController?.dismiss(animated: false, completion: nil)
        }
    }
    
    ///跳转界面
    func showStorbard(storboardKey:String,presentVC:UIViewController) {
        let sb = UIStoryboard(name: storboardKey, bundle: nil);
        let vc = sb.instantiateViewController(withIdentifier: storboardKey);
        
        presentVC.present(vc, animated: true, completion: nil);
    }
    
    ///清除界面中所有控件
    func clearAllView(viewController:UIViewController) {
        let count = viewController.view.subviews.count
    
        for _ in 0 ..< count {
            viewController.view.subviews[0].removeFromSuperview()
        }
    
    }
    
    var viewReconnect = UIView()
    func creatReconnectView(controller: UIViewController) {
        let cgRect = CGRect(x: 0,y: 0,width: screenWidth,height: 60)
        viewReconnect = UIView(frame: cgRect)
        viewReconnect.backgroundColor = UIColor.black
        viewReconnect.alpha = 0.8
        let label = UILabel(frame: cgRect);
        label.text = LanguageHelper.shareInstance.getAppStr(key: "Reconnect")
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        viewReconnect.isHidden = true;
        viewReconnect.addSubview(label)
        controller.view.addSubview(viewReconnect)
    }

    


}
