//
//  DownloadManager.swift
//  AnimationDemo
//
//  Created by xww on 2019/4/29.
//  Copyright © 2019年 cuanbo. All rights reserved.
//

import Foundation
import UIKit

class DownloadManager: NSObject, URLSessionDelegate, URLSessionDownloadDelegate {
    
    //单例模式
    static var shared = DownloadManager()
    
    //下载进度回调
    var onProgress: ((Float) -> ())?
    
    //background session
    lazy var session:URLSession = {
        //只执行一次
        let config = URLSessionConfiguration.background(withIdentifier:
            "background-session")
        let currentSession = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        return currentSession
    }()
    
    //下载代理方法，下载结束
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        //下载结束
        print("下载结束")
        if let onProgress = onProgress {
            onProgress(1)
        }
        
        //输出下载文件原来的存放目录
        print("临时地址:\(location)")
        //location位置转换
        let locationPath = location.path
        //拷贝到用户目录（文件名以时间戳命名）
        let fileName = date2String(Date(), dateFormat: "yyyyMMddHHmmss")
        let documnets = NSHomeDirectory() + "/Documents/" + fileName + ".tmp"
        //创建文件管理器
        let fileManager = FileManager.default
        try! fileManager.moveItem(atPath: locationPath, toPath: documnets)
        print("文件保存到:\(documnets)")
    }
    
    //下载代理方法，监听下载进度
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        //获取进度
        let written = (Float)(totalBytesWritten)
        let total = (Float)(totalBytesExpectedToWrite)
        let pro = written/total
        if let onProgress = onProgress {
            onProgress(pro)
        }
    }
    
    //下载代理方法，下载偏移
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        //下载偏移，主要用于暂停续传
    }
    
    //session完成事件
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        //主线程调用
        DispatchQueue.main.async {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let completionHandler = appDelegate.backgroundSessionCompletionHandler {
                appDelegate.backgroundSessionCompletionHandler = nil
                //调用此方法告诉操作系统，现在可以安全的重新suspend你的app
                completionHandler()
            }
        }
    }
    
    //日期 -> 字符串
    func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
}
