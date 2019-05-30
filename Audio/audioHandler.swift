//
//  StringHandler.swift
//  8BC
//
//  Created by xww on 2019/3/20.
//  Copyright © 2019年 cuanbo. All rights reserved.
//

import Foundation

class AudioHandler {
    //单例var计，防止创建多个对象
    public static let sharedInstance: StringHandler = AudioHandler()
    
    func createSound1(sound: String) {
        //建立的SystemSoundID对象
        var soundID:SystemSoundID = 0
        let soundName = sound+".wav"
       
        //获取声音地址
        let path = Bundle.main.path(forResource: sound, ofType: "wav")
        //地址转换
        if path != nil {
            let baseURL = NSURL(fileURLWithPath: path!)
            //赋值
            AudioServicesCreateSystemSoundID(baseURL, &soundID)
            //提醒（同上面唯一的一个区别）
            AudioServicesPlayAlertSound(soundID)
        }
    }
    
    func createSound2(sound: String) {
        //建立的SystemSoundID对象
        var soundID:SystemSoundID = 0
        let soundName = sound+".wav"
        
        guard let fileUrl = Bundle.main.url(forResource: soundName, withExtension: nil) else {
            return
        }
        //赋值
        AudioServicesCreateSystemSoundID(fileUrl as CFURL, &soundID)
        //提醒（同上面唯一的一个区别）
        AudioServicesPlayAlertSound(soundID)
       
    }
    
    func playAudio(audioName:String) {
        let session = AVAudioSession.sharedInstance()
        var audioPlayer:AVAudioPlayer = AVAudioPlayer()
        //        创建一个异常捕捉语句
        do{
            //启动音频会话的管理，此时会阻断后台音乐的播放
            try session.setActive(true)
            //设置音频操作类别，标示该应用仅支持音频的播放
            try session.setCategory(AVAudioSessionCategoryPlayback)
                    UIApplication.shared.beginReceivingRemoteControlEvents()
            //            定义一个字符常量，描述声音文件的路经
            let path = Bundle.main.path(forResource: audioName, ofType: "mp3")
            //将字符串路径，转换为网址路径
            let soudUrl = URL(fileURLWithPath: path!)
            //对音频播放对象进行初始化，并加载指定的音频文件
            try audioPlayer = AVAudioPlayer(contentsOf: soudUrl)
            audioPlayer.prepareToPlay()
            //设置音频播放对象的音量大小/
            audioPlayer.volume = 1.0
            //设置音频的播放次数，-1为无限循环
            audioPlayer.numberOfLoops = 1
            //开始播放
            audioPlayer.play()
        } catch{
            print(error)
        }
    }
    
}












