//
//  httpHandler.swift
//  http
//
//  Created by xww on 17/12/1.
//  Copyright © 2017年 cuanbo. All rights reserved.
//

import Foundation
import SwiftHTTP

class httpHandler {
    
    //单例设计，防止创建多个对象
    public static let sharedInstance: httpHandler = httpHandler()
    
    func downloadFile(saveFilePath:String) {
        ///下载文件
//        filePath = "/Users/mac/Desktop/SwiftHTTP.zip"
        do {
            let opt = try HTTP.GET("https://codeload.github.com/daltoniam/SwiftHTTP/zip/2.0.0")
            //下载进度
            opt.progress = { progress in
                print("当前进度: \(progress)") //进度是从0到1
                
            }
            //开始下载
            opt.start { response in
                let data:NSData = response.data as NSData
                data.write(toFile: saveFilePath, atomically: true)
                print("HTTP下载文件完毕!保存地址：\(saveFilePath)")
            }
        } catch let error {
            print("HTTP下载文件失败:  \(error)")
        }

    }
    
    
    func uploadFile() {
        let fileUrl = NSURL(string: "http://www.hangge.com/blog/images/logo.png")!
        let fileData = NSData(contentsOf: fileUrl as URL)!
        
        do {
            let opt = try HTTP.POST("http://www.hangge.com/upload.php",parameters: ["param1": "hangge","file1": Upload(data:fileData as Data, fileName: "logo.png", mimeType: "")])
            
            opt.progress = { progress in
                print("当前进度: \(progress)") //进度是从0到1
            }
            
            opt.start { response in
                print(response.description)
                
            }
        } catch let error {
            print("请求失败: \(error)")
        }
    }
    
    
}
