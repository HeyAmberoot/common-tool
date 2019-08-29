//
//  SnapRecord.swift
//
//  Created by xww on 2018/6/28.
//  Copyright © 2018年 amberoot. All rights reserved.
//

import Foundation
import UIKit
//此枚举包含所有截图下载状态
enum SnapRecordState {
    case new,downloaded,failed//,filtered
}

class SnapRecord {
    let strIP:String
    let url:URL?
    let mac:String
    var ipState:String
    var downloadState = SnapRecordState.new
    let rxSourceTxIP:String?
    //初始化默认图片
    var image = UIImage()
    
    init(ip:String,url:URL?,ipState:String,rxSourceTxIP:String,mac:String) {
        self.strIP = ip
        self.url = url
        self.ipState = ipState
        self.rxSourceTxIP = rxSourceTxIP
        self.mac = mac
    }
    
}
