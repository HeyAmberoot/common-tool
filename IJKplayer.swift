//
//  ViewController.swift
//  Preview
//
//  Created by xww on 17/9/9.
//  Copyright © 2017年 cuanbo. All rights reserved.
//

import UIKit
import IJKMediaFramework

class ijkPlay: NSObject{

    //单例设计，防止创建多个对象
    public static let sharedInstance: ijkPlay = ijkPlay()
    
    let ViewForPlayer = UIView()
//    let dao = DAO.sharedInstance
    var player: IJKFFMoviePlayerController!
    ///保存视频流地址的字符串
    var videoStreaming: String!
    var videoTip = UILabel()
    var indicator = UIActivityIndicatorView()
    var oldPlayerView = UIView()

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func initView(cgRect: CGRect,url: String,text:String)
    {
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        videoTip.text = text
        videoTip.textColor = UIColor.lightGray
        videoStreaming = url
        //添加ViewForPlayer到界面
        ViewForPlayer.frame = cgRect
        ViewForPlayer.backgroundColor = UIColor.darkText
//        controller.view.addSubview(ViewForPlayer)
        ViewController.playerContainer.addSubview(ViewForPlayer)
        //初始化播放器
        initPlayer(Url: url)
    }

    func initPlayer(Url: String) {
        //防止重复打开播放器导致内存溢出
        if player != nil {
            player.shutdown()//关闭播放器
            oldPlayerView = player.view
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+6) {
//                self.oldPlayerView.removeFromSuperview()
//            }
            indicator.removeFromSuperview()
            videoTip.removeFromSuperview()
            player = nil
            print("++++++++重启播放器+++++++")
        }
        
        videoStreaming = Url
        let url = NSURL(string: Url)
        //options是对数据的处理，videotoolbox解码，设置音频视频等属性，都要有这个数据
        let options = IJKFFOptions.byDefault()
        //设置解码方式: 0-软解码；1-硬解码
//        options?.setPlayerOptionIntValue(1, forKey: "videotoolbox")
        //开启硬解码
//        options?.setPlayerOptionValue("1", forKey: "videotoolbox")
        //设置播放器缓冲: 0-关闭缓冲；1-开启缓冲；默认是1
//        options?.setPlayerOptionIntValue(1, forKey: "packet-buffering")
        // 最大缓存是3000（3s），可以依据自己的需求修改
//        options?.setPlayerOptionIntValue(1000, forKey: "max_cached_duration")
        //设置自动转屏
//        options?.setFormatOptionIntValue(0, forKey: "auto_convert")
        //设置重连：0-关闭重连；1-开启重连；
//        options?.setFormatOptionIntValue(1, forKey: "reconnect")
        //如果使用rtsp协议，可以优先用tcp（默认udp）
//        options?.setPlayerOptionValue("tcp", forKey: "rtsp_transport")
        //开启环路滤波IJK_AVDISCARD（0比48清楚，但解码开销大，48基本没有开启环路滤波，清晰度低，解码开销小）
//        options?.setCodecOptionIntValue(48, forKey: "skip_loop_filter")
        //帧速率(fps)-可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97
//        options?.setPlayerOptionIntValue(29.97, forKey: "r")
        
//        //设置音量大小，256为标准音量。要设置成两倍音量时则输入512，依此类推
//        options?.setPlayerOptionIntValue(256, forKey: "vol")
        //设置静音
        options?.setPlayerOptionValue("1", forKey: "an")
//        IJKFFMoviePlayerController.setLogLevel(IJKLogLevel(rawValue: 3))
//        IJKFFMoviePlayerController.setLogReport(false)
 
        //初始化播放器，播放在线视频或直播
        player = IJKFFMoviePlayerController(contentURL: url as URL?, with: options)
        //播放页面视图宽高自适应
        let autoresize = UIViewAutoresizing.flexibleWidth.rawValue | UIViewAutoresizing.flexibleHeight.rawValue
        player.view.autoresizingMask = UIViewAutoresizing(rawValue: autoresize)
        //设置视频缓存大小，缓存大延迟大，缓存小延迟小
        player.setPlayerOptionIntValue(0, forKey: "framedrop")
        
        player.view.frame = self.ViewForPlayer.bounds
        player.scalingMode = .aspectFit//缩放模式
        player.shouldAutoplay = true //开启自动播放
//        player.allowsMediaAirPlay = true
        //        player.shouldShowHudView = true
        //        self.view.autoresizesSubviews = true
        
        self.ViewForPlayer.addSubview(player.view)
        //添加indicatorView到ViewForPlayer
        ViewForPlayer.addSubview(indicator)
        setIndicatorViewConstraints()
        //添加label到ViewForPlayer
        ViewForPlayer.addSubview(videoTip)
        setLabelViewConstraints()
        /////////////////
        self.player.currentPlaybackTime = 1
        //self.player.playbackState
        DispatchQueue.main.async {
            //开启播放器
            self.player.prepareToPlay()
        }

        videoTip.text = " "
        indicator.startAnimating()
        //注册ijk播放器的通知
        NotificationCenter.default.addObserver(self, selector: #selector(moviePlayBackFinish), name: NSNotification.Name.IJKMPMoviePlayerPlaybackDidFinish, object: player)
        NotificationCenter.default.addObserver(self, selector: #selector(loadStateDidChange), name: NSNotification.Name.IJKMPMoviePlayerLoadStateDidChange, object: player)
        //        NotificationCenter.default.addObserver(self, selector: #selector(moviePlayBackStateDidChange), name: NSNotification.Name.IJKMPMoviePlayerPlaybackStateDidChange, object: player)
        //        NotificationCenter.default.addObserver(self, selector: #selector(mediaIsPreparedToPlayDidChange), name: NSNotification.Name.IJKMPMediaPlaybackIsPreparedToPlayDidChange, object: player)
    }
    
    
    //视频播放结束
    @objc func moviePlayBackFinish(notifycation:Notification)  {
        let playerN = notifycation.object as! IJKFFMoviePlayerController

        if playerN.bufferingProgress == 0 {
            print("视频加载失败")
        }
        let reason = notifycation.userInfo?[IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] as! Int
        NSLog("--------------moviePlayBackFinish：\(reason)")
        
        switch (reason) {
        case 0://playbackEnded
            indicator.startAnimating()
            if !videoStreaming.isEmpty {
                initPlayer(Url: videoStreaming)
            }
            
            break
            
        case 2://userExited
            
            break
            
        case 1://playbackError
            print("播放错误，需要重新播放：\(reason)")
            videoTip.text = "获取视频失败"
            indicator.stopAnimating()
            break
        default:
            break
        }
    }
    
    ///加载状态改变了
    @objc func loadStateDidChange(notifycation:Notification)  {
        let playerN = notifycation.object as! IJKFFMoviePlayerController
        let loadState = player?.loadState.rawValue
        
        NSLog("--------------加载状态loadStateDidChange:\(loadState!)")
        //        IJKMPMovieLoadState
        if loadState == 3 {//开始播放视频
            indicator.stopAnimating()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.6) {
                self.oldPlayerView.removeFromSuperview()
            }
            
        }else if loadState == 4 {//网络不好导致了暂停
            indicator.startAnimating()
            if !videoStreaming.isEmpty {
                initPlayer(Url: videoStreaming)
            }
        }
        switch self.player.loadState {
        // 状态为缓冲几乎完成，可以连续播放
        case IJKMPMovieLoadState.playthroughOK:
            
//            videoTip.text = "加载状态为缓冲几乎完成，可以连续播放"
            break
        // 可以播放状态
        case IJKMPMovieLoadState.playable:
//            videoTip.text = "加载状态为可以播放状态"
            
            break
        // 缓冲中
        case IJKMPMovieLoadState.stalled:
            
            videoTip.text = "网络不好导致了暂停"
            indicator.startAnimating()
            break
        default:
            print("加载状态-loadStateDidChange: \(loadState!)")//加载状态未知
        }
  
    }
    
    ///准备播放的媒体改变了
    @objc func mediaIsPreparedToPlayDidChange(notifycation:Notification)  {
        _ = notifycation.object as! IJKFFMoviePlayerController
        NSLog("--------------mediaIsPreparedToPlayDidChange")
        videoTip.text = "mediaIsPreparedToPlayDidChange"
        
    }
    ///视频播放状态改变了
    @objc func moviePlayBackStateDidChange(notifycation:Notification)  {
        let playerN = notifycation.object as! IJKFFMoviePlayerController

        //播放 1  暂停2  播放完成 0
        NSLog("--------------播放状态改变了：\(player?.playbackState.rawValue ?? 9)")
//        videoTip.text = "播放状态改变了：\(player?.playbackState.rawValue ?? 9)"
        switch player?.playbackState.rawValue ?? 9 {
        case 0://停止
//            initPlayer(Url: videoStreaming)
            break
            
        case 1://播放

            break
            
        case 2://暂停
//            initPlayer(Url: videoStreaming)

            break
        case 4://播放
            
            break
        default:
            break
            
        }
        
    }

    
    
    ///获取视频流
    func getVideoStreaming(_ notification: Notification) {
//        videoStreaming = dao.readVideoStreaming(key: key_VideoStreaming)
        initPlayer(Url: videoStreaming)
        
    }
 
    func shutdownPlayer() {
        
        if self.player != nil {
            //关闭播放器
            self.player.shutdown()
        }
        
    }

    func setLabelViewConstraints() {
        //系统默认会给autoresizing 约束,要关闭autoresizing才能让自定义的约束生效，否则程序崩溃
        videoTip.translatesAutoresizingMaskIntoConstraints = false
        //添加约束:"哪个控件" 的 “什么属性“ "等于/大于/小于" “另一个控件” 的 “什么属性” 乘以 "多少" 加上 "多少"
        let Constraint_centerX = NSLayoutConstraint(item: videoTip, attribute: .centerX, relatedBy: .equal, toItem: ViewForPlayer, attribute: .centerX, multiplier: 1, constant: 0)
        
        let Constraint_centerY = NSLayoutConstraint(item: videoTip, attribute: .centerY, relatedBy: .equal, toItem: ViewForPlayer, attribute: .centerY, multiplier: 1, constant: 0)
        
        let Constraint_width = NSLayoutConstraint(item: videoTip, attribute: .width, relatedBy: .lessThanOrEqual, toItem: ViewForPlayer, attribute: .width, multiplier: 1, constant: 0)
        
        let Constraint_height = NSLayoutConstraint(item: videoTip, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .height, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([Constraint_centerX,Constraint_centerY,Constraint_width,Constraint_height])
    }

    func setIndicatorViewConstraints() {
        //系统默认会给autoresizing 约束,要关闭autoresizing才能让自定义的约束生效，否则程序崩溃
        indicator.translatesAutoresizingMaskIntoConstraints = false
        //添加约束:"哪个控件" 的 “什么属性“ "等于/大于/小于" “另一个控件” 的 “什么属性” 乘以 "多少" 加上 "多少"
        let Constraint_centerX = NSLayoutConstraint(item: indicator, attribute: .centerX, relatedBy: .equal, toItem: ViewForPlayer, attribute: .centerX, multiplier: 1, constant: 0)
        
        let Constraint_centerY = NSLayoutConstraint(item: indicator, attribute: .centerY, relatedBy: .equal, toItem: ViewForPlayer, attribute: .centerY, multiplier: 1, constant: 0)
        
        let Constraint_width = NSLayoutConstraint(item: indicator, attribute: .width, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .width, multiplier: 1, constant: 20)
        
        let Constraint_height = NSLayoutConstraint(item: indicator, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .height, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([Constraint_centerX,Constraint_centerY,Constraint_width,Constraint_height])
    }
    


}

