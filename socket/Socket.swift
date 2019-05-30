//
//  File.swift
//  Preview
//
//  Created by xww on 17/9/12.
//  Copyright © 2017年 cuanbo. All rights reserved.
//

import Foundation
import UIKit

class TCP_GCDAsyncSocket: GCDAsyncSocketDelegate {
   
    //单例var计，防止创建多个对象
    public static let sharedInstance: TCP_GCDAsyncSocket = TCP_GCDAsyncSocket()
    
    let dao = DAO.sharedInstance
    let viewTool = ViewTool.sharedInstance
  
    public var ConnectSucced = false
    ///存放当前连接的设备IP地址
    var serverIP: String!
    var serverPort: String!
    //Socket
    var clientSocket: GCDAsyncSocket!
    var mainQueue = DispatchQueue.main
    
    func ConnectToService() {
        print("连接服务器")
        let ser = dao.readDao(key: key_Service) as! Dictionary<String,Any>
        self.serverIP = ser["ip"] as! String//"192.168.88.176"//
        self.serverPort = ser["port"] as! String//"8080"//

        if UInt16(self.serverPort) == nil {
            ConnectSucced = false
            return
        }
        //连接服务器
        do{
            self.clientSocket = GCDAsyncSocket()
            self.clientSocket.delegate = self
            self.clientSocket.delegateQueue = __dispatch_get_global_queue(0,0)//DispatchQueue.global(self)
            try self.clientSocket.connect(toHost: self.serverIP, onPort: UInt16(self.serverPort)!)
        }
        catch{
            print(error)
//            self.textViewTip.text = "错误：\(error)"
            ConnectSucced = false
        }
        
        
       
    }

    func SendData(socket: GCDAsyncSocket,str: String) {
        //let output = [out]
//        let da:NSData = order_matrix.videoSwitch(Input: input,Output: [out])
        //发送字符串数据给服务器
        //let serviceStr:NSMutableString = NSMutableString()
        //serviceStr.append(tfMessage.text!)
        //serviceStr.append("/n")
        //clientSocket.write(serviceStr.data(using: String.Encoding.utf8.rawValue), withTimeout: -1, tag: 0)
        //发送字节数据给服务器
//        let byte:[UInt8] = [0x1E,0x00,0x20,0x1F]
//        let data = NSData(bytes: byte, length: 4)
        let str2 = "\(str)\r"
        let data = str2.data(using: String.Encoding.utf8,allowLossyConversion: false)
        NSLog("sendOrder:\(str2)")
        socket.write(data!, withTimeout: -1, tag: 0)
    }
    
    func SendData(socket: GCDAsyncSocket, byte: [UInt8]) {
        //发送字节数据给服务器
//        let byte:[UInt8] = [0x1E,0x00,0x20,0x1F]
        let data = NSData(bytes: byte, length: byte.count)
    
        socket.write(data as Data?, withTimeout: -1, tag: 0)
        NSLog("sendOrder:\(byte)")
    }

    func socket(_ sock: GCDAsyncSocket!, didConnectToHost host: String!, port: UInt16) {
        NSLog(" **连接服务器成功** \n Host:\(host!) \n Port:\(port) \n Sock:\(sock!)")
        sock.readData(withTimeout: -1, tag: 0)
        //连接成功标志位
        ConnectSucced = true

        //修改控件只能在主线程
        mainQueue.async(execute: {
            //发送连接服务器成功的通知
            NotificationCenter.default.post(name: notification_connected, object: nil)
          
        })
        
    }
 
    func socketDidDisconnect(_ sock: GCDAsyncSocket!, withError err: Error!) {
        if sock == nil {
            return
        }
        NSLog("**与服务器断开连接**")
        ConnectSucced = false
        if err == nil {
            return
        }
        print(String(describing: err.localizedDescription))
        let connectError = String(describing: err.localizedDescription)
        //修改控件只能在主线程
        mainQueue.async(execute: {
            let dataDict = ["err": connectError]
//            connectError == "Connection refused" "Operation timed out" "Network is unreachable"
                //发送断开连接的通知
                NotificationCenter.default.post(name: notification_disconnect, object: nil, userInfo: dataDict)
            
        })
        //连接设备时，连接失败自动重新连接
        if isDeviceService {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                self.ConnectToService()
            }
        }
        
    }
    
    func socket(_ sock: GCDAsyncSocket!, didRead data: Data!, withTag tag: Int) {
        
        //1. 获取客户发来的数据，把NSData 转为 NSString
        let readClientDataString:NSString? = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        //将data转存到[UInt8]数组
        let resultByte = (data?.withUnsafeBytes {
            [UInt8](UnsafeBufferPointer(start: $0, count: (data?.count)!))
            })! as [UInt8]

        if readClientDataString == nil {
            //每次读完数据后，都要调用监听数据的方法，否则只能接收一次数据
            sock.readData(withTimeout: -1, tag: 0)
            SendData(socket:sock,str: "DataCount:0")
            return
        }
        print(readClientDataString!)

      
        //每次读完数据后，都要调用监听数据的方法，否则只能接收一次数据
        sock.readData(withTimeout: -1, tag: 0)
    }

    func disConnect() {
        if self.clientSocket != nil {
            self.clientSocket.disconnect()
        }
        
    }

    


    
    
}
