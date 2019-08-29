//
//  ImagePicker.swift
//
//  Created by xww on 2018/11/21.
//  Copyright © 2018年 amberoot. All rights reserved.
//

import Foundation
import UIKit

extension QRCodeViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        //获取选择的原图
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //二维码读取
        let ciImage:CIImage=CIImage(image:image)!
        let context = CIContext(options: nil)
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context,
                                  options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
        if let features = detector?.features(in: ciImage) {
            print("扫描到二维码个数：\(features.count)")
            //遍历所有的二维码，并框出
            for feature in features as! [CIQRCodeFeature] {
                print(feature.messageString ?? "")
            }
        }
        
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
    }
}
