//
//  ImageFiltration.swift
//
//  Created by xww on 2018/6/28.
//  Copyright © 2018年 amberoot. All rights reserved.
//

import Foundation
import UIKit

class ImageFiltration : Operation {
    
    let snapRecord: SnapRecord
    
    init(snapRecord: SnapRecord) {
        self.snapRecord = snapRecord
    }
    
    //在子类中重载Operation的main方法来执行实际的任务。
    override func main () {
        if self.isCancelled {
            return
        }
        
        if self.snapRecord.downloadState != .downloaded {
            return
        }
        
        if let filteredImage = self.applySepiaFilter(self.snapRecord.image) {
            self.snapRecord.image = filteredImage
//            self.snapRecord.state = .filtered
        }
    }
    
    //给图片添加棕褐色滤镜
    func applySepiaFilter(_ image:UIImage) -> UIImage? {
        let inputImage = CIImage(data:UIImagePNGRepresentation(image)!)
        
        if self.isCancelled {
            return nil
        }
        let context = CIContext(options:nil)
        let filter = CIFilter(name:"CISepiaTone")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(0.8, forKey: "inputIntensity")
        let outputImage = filter?.outputImage
        
        if self.isCancelled {
            return nil
        }
        
        let outImage = context.createCGImage(outputImage!, from: outputImage!.extent)
        let returnImage = UIImage(cgImage: outImage!)
        return returnImage
    }
}
