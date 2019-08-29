//
//  Canvas.swift
//  WisRoomGDiOS
//
//  Created by xww on 2019/4/16.
//  Copyright © 2019年 amberoot. All rights reserved.
//

import UIKit

class Canvas: UIView {
    //负责线条的生成、操作与管理
    private let pathCreator:PathCreator
    //是否处于擦除状态
    private var isInErasering:Bool
    //橡皮擦视图
    private let eraserView:UIView
    let colorCustom = ColorCustom.sharedInstance
    
    override init(frame: CGRect) {
        
        isInErasering = false
        pathCreator = PathCreator()
        
        eraserView = UIView.init()
        eraserView.frame = CGRect(x: 0, y: 0, width: 16, height: 18)
        eraserView.backgroundColor = UIColor.white
        eraserView.alpha = 0
        eraserView.layer.cornerRadius = 3
        //
        super.init(frame: frame)
        
        self.layer.borderColor = colorCustom.DodgerBlue3.cgColor
        self.layer.borderWidth = 2
        self.backgroundColor = UIColor.clear
        
        self.addSubview(eraserView)
        //撤销按钮
        let revokeBtn = UIButton(type: UIButtonType.system)
        revokeBtn.frame = CGRect(x: 20, y: 20, width: 60, height: 30)
        revokeBtn.setTitle("撤销", for: UIControlState.normal)
        revokeBtn.addTarget(self, action: #selector(revokeBtnClick), for: UIControlEvents.touchUpInside)
        self.addSubview(revokeBtn)
        
        let cleanBtn = UIButton(type: UIButtonType.system)
        cleanBtn.frame = CGRect(x: 90, y: 20, width: 60, height: 30)
        cleanBtn.setTitle("清空", for: UIControlState.normal)
        cleanBtn.addTarget(self, action: #selector(cleanBtnClick), for: UIControlEvents.touchUpInside)
        self.addSubview(cleanBtn)
        
//        let eraserBut = UIButton(type: UIButtonType.system)
//        eraserBtn.frame = CGRect(x: 160, y: 20, width:60, height: 30)
//        eraserBtn.setTitle("橡皮檫", for: UIControlState.normal)
//        eraserBtn.setTitle("画笔", for: UIControlState.selected)
//        eraserBtn.addTarget(self, action: #selector(eraserBtnClick(btn:)), for: UIControlEvents.touchUpInside)
//        self.addSubview(eraserBut)
        
        let ges = UIPanGestureRecognizer(target: self, action:#selector(handleGes(ges:)))
        ges.maximumNumberOfTouches = 1
        self.addGestureRecognizer(ges)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        
    }
    
    @objc private func handleGes(ges:UIPanGestureRecognizer) -> Void {
        let point = ges.location(in: self)
        switch ges.state {
        case UIGestureRecognizerState.began:
            if isInErasering {
                //擦除状态,显示出橡皮擦
                eraserView.alpha = 1
                eraserView.center = point
            }
            //生成新的一笔
            pathCreator.addNewPath(to: point,isEraser: isInErasering)
            self.setNeedsDisplay()
        case UIGestureRecognizerState.changed:
            if isInErasering {
                //移动橡皮擦
                eraserView.center = ges.location(in: self)
            }
            //更新当前笔画路径
            pathCreator.addLineForCurrentPath(to: point,isEraser:isInErasering)
            self.setNeedsDisplay()
        case UIGestureRecognizerState.ended:
            if isInErasering {
                //擦除状态,隐藏橡皮擦
                eraserView.alpha = 0
                eraserView.center = ges.location(in: self)
            }
            //更新当前笔画路径
            pathCreator.addLineForCurrentPath(to: point,isEraser: isInErasering)
            self.setNeedsDisplay()
        case UIGestureRecognizerState.cancelled:
            print("cancel")
        case UIGestureRecognizerState.failed:
            print("fail")
        default:
            return
        }
    }
    
    override public func draw(_ rect: CGRect) {
        //画线
        pathCreator.drawPaths()
    }
    
    @objc private func revokeBtnClick()->Void{
        //撤销操作
        pathCreator.revoke()
        self.setNeedsDisplay()
    }
    
    @objc private func cleanBtnClick()->Void{
        //清空操作
        pathCreator.clean()
        self.setNeedsDisplay()
    }
    
    @objc private func eraserBtnClick(btn:UIButton)->Void{
        //切换画图与擦除状态
        if btn.isSelected {
            btn.isSelected = false
            isInErasering = false
        }else{
            btn.isSelected = true
            isInErasering = true
        }
    }
   

}
