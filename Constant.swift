//
//  Constant.swift
//  IPC
//
//  Created by xww on 17/9/27.
//  Copyright © 2017年 cuanbo. All rights reserved.
//
import UIKit
/////////////////////////全局变量////////////////////////////

///沙盒文档路径
let documentsPath = NSHomeDirectory() + "/Documents/"
/*
 iphoneXS MAX(6.5英寸)        -- *pt | scale: | 2688×1242px
 iphoneXS(5.8英寸)            -- *pt | scale: | 2436*1125px
 iphoneXR(6.1英寸)            -- *pt | scale: | 1792*828px
 iphoneX(5.8英寸)             -- 375*812pt | scale:3 | 1125*2478px
 iphone6/6s/7/8(4.7英寸)      -- 375*667pt | scale:2 | 1125*2478px
 iphone6/6s/7/8Plus(5.5英寸)  -- 414*736pt | scale:3 | 1242*2208px
 iphone5c/5/5s/SE(4.0英寸)    -- 320*568pt | scale:2 | 640*1136px
 ipad(英寸)                   -- 768*1024pt | scale:2 | 1536*2048px
 */
///屏幕宽高
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
///屏幕缩放比
let screenScale = UIScreen.main.scale


/////////////////////////通知//////////////////////////////

///服务器成功连接的通知
let notification_connected = NSNotification.Name(rawValue: "NotificationConnected")
///服务器断开连接的通知
let notification_disconnect = NSNotification.Name(rawValue: "NotificationDisconnect")
///设置系统语言，发通知刷新所有界面
let notification_languageChange = NSNotification.Name("NotificationLanguageChange")
///连接设备
let notification_connectDevice = NSNotification.Name(rawValue: "NotificationConnectDevice")


////////读取或写入数据进localData.plist的key//////////////////

///保存即将连接的服务器IP的Key
let key_service = "Service_Dictionary"
///保存语言数据的Key
let key_language = "Language_Int"



////////////////////////////////////////////////////////
enum Align:String {
    case topLeft = "0"
    case topCenter = "1"
    case topRight = "2"
    case middleLeft = "3"
    case middleCenter = "4"
    case middleRight = "5"
    case bottomLeft = "6"
    case bottomCenter = "7"
    case bottomRight = "8"
}






