//
//  PathCreator.swift
//  WisRoomGDiOS
//
//  Created by xww on 2019/4/16.
//  Copyright © 2019年 cuanbo. All rights reserved.
//

import Foundation
import UIKit

///Bezier curve-贝塞尔曲线：它通过控制曲线上的四个点（起始点、终止点以及两个相互分离的中间点）来创造、编辑图形
//每条子线段信息
struct BezierInfo{
    let path:UIBezierPath//具体线段
    let color:UIColor//线段对应颜色
    init(path:UIBezierPath,color:UIColor){
        self.path = path
        self.color = color
    }
}

class PathCreator{
    //所有笔画
    private var MutArrayPaths:[NSMutableArray]?
    //笔画内当前子线段
    private var currentBezierPathInfo:BezierInfo?
    //当前笔画的所有子线段
    private var currentPath:NSMutableArray?
    //当前笔画已经采集处理了几个触摸点
    private var pointCountInOnePath = 0
    
    static let colors = [UIColor.red,UIColor.red,UIColor.red,UIColor.red,UIColor.red,UIColor.red,UIColor.red]
    init() {
        MutArrayPaths = []
    }
    
    ///添加新笔画
    func addNewPath(to:CGPoint,isEraser:Bool)->Void{
        //创建起始线段
        let path = UIBezierPath()
        path.move(to: to)

        if !isEraser {
            path.lineWidth = 5
            path.lineJoinStyle = CGLineJoin.round
            path.lineCapStyle = CGLineCap.round
            //绑定线段与颜色信息
            currentBezierPathInfo = BezierInfo(path: path, color: PathCreator.colors[0])
        }else{
            path.lineWidth = 16
            path.lineJoinStyle = CGLineJoin.bevel
            path.lineCapStyle = CGLineCap.square
            //处于擦除模式，颜色与画板背景色相同
            currentBezierPathInfo = BezierInfo(path: path, color: UIColor.clear)
        }
        //新建一个笔画
        currentPath = NSMutableArray.init()
        //将起始线段加入当前笔画
        currentPath!.add(currentBezierPathInfo!)
        pointCountInOnePath = 0
        //将当前笔画加入笔画数组
        MutArrayPaths!.append(currentPath!)
    }
    
    ///添加新的点，更新当前笔画路径
    func addLineForCurrentPath(to:CGPoint,isEraser:Bool) -> Void {
        pointCountInOnePath += 1//同一笔画内，每7个点换一次颜色
        if pointCountInOnePath % 7 == 0{//换颜色
            if let currentBezierPathInfo = currentBezierPathInfo{
                //将当前点加入当前子线段,更新当前子线段路径
                currentBezierPathInfo.path.addLine(to: to)
            }
            //生成新的子线段
            let path = UIBezierPath()
            
            path.move(to: to)
            path.lineJoinStyle = CGLineJoin.round
            path.lineCapStyle = CGLineCap.round
            if !isEraser{
                path.lineWidth = 5
                //给当前子线段设置下一个颜色
                currentBezierPathInfo = BezierInfo(path: path, color: PathCreator.colors[currentPath!.count % 7])
            }else{
                path.lineWidth = 16
                //处于擦除模式，颜色与画板背景色相同
                currentBezierPathInfo = BezierInfo(path: path, color: UIColor.clear)
            }
            //将当前子线段加入当前笔画
            currentPath!.add(currentBezierPathInfo!)
        }else{
            if let currentBezierPathInfo = currentBezierPathInfo{
                //将当前点加入当前子线段,更新当前子线段路径
                currentBezierPathInfo.path.addLine(to: to)
            }
        }
    }
    
    func drawPaths()->Void{
        //画线
        let pathCount = MutArrayPaths!.count
        for i in 0..<pathCount{
            //取出所有笔画
            let onePath = MutArrayPaths![i]
            let onePathCount = onePath.count
            for j in 0..<onePathCount{
                //绘制每条笔画内每个子线段
                let pathInfo = onePath.object(at: j) as! BezierInfo
                pathInfo.color.set()
                pathInfo.path.stroke()
            }
        }
    }
    
    func revoke()->Void{
        //移走上一笔画
        if MutArrayPaths!.count > 0 {
            MutArrayPaths!.removeLast()
        }
    }
    
    func clean()->Void{
        //移走所有笔画
        MutArrayPaths!.removeAll()
    }
}

