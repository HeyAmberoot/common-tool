//
//  ImageDownloader.swift
//
//  Created by xww on 2018/6/28.
//  Copyright © 2018年 amberoot. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloader: Operation {
    weak var snapRecord: SnapRecord?
    
    init(snapRecord: SnapRecord) {
        self.snapRecord = snapRecord
    }
    
    //在子类中重载Operation的main方法来执行实际的任务。
    override func main() {
        
        //在开始执行前检查撤消状态。任务在试图执行繁重的工作前应该检查它是否已经被撤消。
        if self.isCancelled {
            return
        }
        //sleep(1) //这个只是为了便于测试观察

        //下载图片。
        var imageData:Data?
        if self.snapRecord!.url != nil {
            imageData = try? Data(contentsOf: self.snapRecord!.url!)
            NSLog("下载图片成功")
        }else {
            self.snapRecord!.downloadState = .failed
        }


        //再一次检查撤销状态。
        if self.isCancelled {
            return
        }

        //如果有数据，创建一个图片对象并加入记录，然后更改状态。如果没有数据，将记录标记为失败并设置失败图片。
        if imageData != nil {
            let imge = UIImage(data:imageData!)
            if imge != nil {
                self.snapRecord!.image = imge!
                self.snapRecord!.downloadState = .downloaded
            }else {
                self.snapRecord!.downloadState = .failed
            }
        } else {
            self.snapRecord!.downloadState = .failed
//            self.snapRecord.image = #imageLiteral(resourceName: "fail")
        }
    }
}
