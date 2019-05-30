//
//  SnapOperations.swift
//  CBCont
//
//  Created by xww on 2018/6/28.
//  Copyright © 2018年 cuanbo. All rights reserved.
//

import Foundation
import UIKit

class SnapOperations {
    //追踪进行中的和等待中的下载操作
    lazy var downloadsInProgress = [IndexPath:Operation]()
    //图片下载队列
    lazy var downloadQueue:OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        //一个队列中同时只有一个线程运行
        queue.maxConcurrentOperationCount = 5
        return queue
    }()
    
    //追踪进行中的和等待中的滤镜操作
    lazy var filtrationsInProgress = [IndexPath:Operation]()
    //图片处理队列
    lazy var filtrationQueue:OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Image Filtration queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}
