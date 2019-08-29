//
//  ViewController.swift
//  AnimationDemo
//
//  Created by xww on 2019/4/24.
//  Copyright © 2019年 amberoot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadFileInBackground()
    }
    
    // MARK: 后台下载文件
    func downloadFileInBackground() {
        //下载地址
        let url = URL(string: "https://dldir1.qq.com/dlomg/qqcom/mini/QQNewsMini5.exe")
        //请求
        let request = URLRequest(url: url!)
        
        //下载任务
        let downloadTask = DownloadManager.shared.session.downloadTask(with: request)
        
        //使用resume方法启动任务
        downloadTask.resume()
        
        //实时打印出下载进度
        DownloadManager.shared.onProgress = { (progress) in
            OperationQueue.main.addOperation {
                print("下载进度：\(progress)")
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

