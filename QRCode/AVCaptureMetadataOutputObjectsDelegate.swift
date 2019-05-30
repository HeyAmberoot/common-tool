//
//  AVCaptureMetadataOutputObjectsDelegate.swift
//  learnRealm
//
//  Created by xww on 2018/11/19.
//  Copyright © 2018年 cuanbo. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    //只要解析到数据就会调用
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
        //1. 获取扫描到的数据
        if metadataObjects.last != nil
        {
            print((metadataObjects.last as AnyObject).stringValue!)
        }
        //2. 获取二维码的位置
        //2.1 转换坐标
        for object in metadataObjects
        {
            //print(object)
            //判断当前获取的数据是否是机器可识别的类型
            if object is AVMetadataMachineReadableCodeObject
            {
                //将界面坐标转换成可识别坐标
                let codeObject = PreviewLayer.transformedMetadataObject(for: object ) as! AVMetadataMachineReadableCodeObject
                //codeObject里有bounds和corners，bounds的数据是1个CGPoint+长*宽；corners的数据有4个CGPoint
                //print(codeObject)
                //绘制图形
                drawCorners(codeObject: codeObject)
            }
        }
    }
    
    
    
    ///绘制识别的二维码边框
    private func drawCorners(codeObject:AVMetadataMachineReadableCodeObject)
    {
        if codeObject.corners.isEmpty
        {
            return
        }
        //清空之前的图层
        clearCorner()
        //1. 创建图层
        let layer = CAShapeLayer()
        layer.lineWidth = 3
        layer.strokeColor = UIColor.blue.cgColor
        layer.fillColor = UIColor.clear.cgColor//把图层的填充颜色设置成透明
        //2. 创建路径
        //        layer.path = UIBezierPath(rect: CGRect(x: 100, y: 100, width: 200, height: 200)).cgPath
        let path = UIBezierPath()
        var point = CGPoint()
        var index: Int = 0
        //2.1 移动到第一个点
        let pointFirst = codeObject.corners.first
        path.move(to: pointFirst!)
        //2.2 移动到其他的点
        while index < codeObject.corners.count - 1
        {
            index = index + 1
            point = codeObject.corners[index]
            path.addLine(to: point)
        }
        //2.3 关闭路径
        path.close()
        //2.4 绘制路径
        layer.path = path.cgPath
        
        //3. 将绘制好的图层添加到drawLayer上
        drawLayer.addSublayer(layer)
    }
    
    ///清空二维码边线
    private func clearCorner()
    {
        //1. 判断drawLayer上是否有其他图层
        if drawLayer.sublayers == nil || drawLayer.sublayers?.count == 0
        {
            return
        }
        //2. 移除所有子图层
        for sublayer in drawLayer.sublayers!
        {
            sublayer.removeFromSuperlayer()
        }
    }
    
}
