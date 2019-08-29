//
//  File.swift
//
//  Created by xww on 17/9/12.
//  Copyright © 2017年 amberoot. All rights reserved.
//

import Foundation
import UIKit

class TCP_GCDAsyncSocket: GCDAsyncSocketDelegate {
   
    //单例var计，防止创建多个对象
    public static let sharedInstance: TCP_GCDAsyncSocket = TCP_GCDAsyncSocket()
    
    let xmlH = xmlHelper.sharedInstance
    let dao = DAO.sharedInstance
    //Socket
    var serverIP: String!
    var serverPort = "9090"
    var clientSocket: GCDAsyncSocket!
    var mainQueue = DispatchQueue.main
    public var feedbackStr = String()
    public var feedbackFlag = Bool()
    var clientSocketTransducer: GCDAsyncSocket!
    var TransducerConnected = false
    
    func ConnectTransducer(IP:String,Port:String) {
        
        if UInt16(Port) == nil {
            return
        }
        //连接服务器
        do{
            clientSocketTransducer = GCDAsyncSocket()
            clientSocketTransducer.delegate = self
            clientSocketTransducer.delegateQueue = __dispatch_get_global_queue(0,0)//DispatchQueue.global(self)
            try clientSocketTransducer.connect(toHost: IP, onPort: UInt16(Port)!)
            
        }
        catch{
            print(error)
        }
    }

    func ConnectToService() {
        print("连接服务器")
        let ser = dao.readServiceData(key: key_Service)
        self.serverIP = ser?["ip"] as! String//"192.168.88.176"//
        self.serverPort = ser?["port"] as! String//"8080"//

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
        
        socket.write(data!, withTimeout: -1, tag: 0)
        NSLog("sendOrder:\(str2)")
        
  
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
        
        if sock == clientSocketTransducer {
            TransducerConnected = true
            SendData(socket: clientSocketTransducer, byte: [0x01,0x03,0x00,0x00,0x00,0x09,0x85,0xCC,0x0D])
            return
        }
        //连接成功标志位
        ConnectSucced = true
        IPAddress = host!

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
        if sock == clientSocketTransducer {
            common.showAlertView(mes: "传感器连接失败！", controller: secondViewController)
            TransducerConnected = false
            return
        }
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
    
    var startXML = false
    func socket(_ sock: GCDAsyncSocket!, didRead data: Data!, withTag tag: Int) {
        
        //1. 获取客户发来的数据，把NSData 转为 NSString
        let readClientDataString:NSString? = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        //将data转存到[UInt8]数组
        let resultByte = (data?.withUnsafeBytes {
            [UInt8](UnsafeBufferPointer(start: $0, count: (data?.count)!))
            })! as [UInt8]
        //传感器返回数据///////////////////////
        if resultByte.count == 23 && sock == clientSocketTransducer {
            let temperature = [resultByte[5],resultByte[6]]
            let humidity = [resultByte[3],resultByte[4]]
            let CO2 = [resultByte[13],resultByte[14]]
            let light = [resultByte[17],resultByte[18],resultByte[19],resultByte[20]]
            //转成正确数据
            let tem = CRC16.sharedInstance.CRC(bys: temperature)
            let hum = CRC16.sharedInstance.CRC(bys: humidity)
            let co2 = CRC16.sharedInstance.CRC(bys: CO2)
            let li = CRC16.sharedInstance.CRC(bys: light)
            let info = ["temperature":tem,"humidity":hum,"CO2":co2,"light":li]
            //每次读完数据后，都要调用监听数据的方法，否则只能接收一次数据
            sock.readData(withTimeout: -1, tag: 0)
            mainQueue.async(execute: {
                NotificationCenter.default.post(name: notification_Transducer, object: nil,userInfo:info)
            })
            return
        }
       
        if readClientDataString == nil {
            //每次读完数据后，都要调用监听数据的方法，否则只能接收一次数据
            sock.readData(withTimeout: -1, tag: 0)
            SendData(socket:sock,str: "DataCount:0")
            return
        }
        print(readClientDataString!)

        //有指令反馈
        if feedbackFlag {
            feedbackStr = readClientDataString! as String
            mainQueue.async(execute: {
                NotificationCenter.default.post(name: notification_FeedBack, object: nil)
            })
        }
        //检查中控卡是否注册成功
        if readClientDataString!.hasPrefix("<COM:1") {
            NSLog("中控卡注册成功！")
        }
        if readClientDataString!.hasPrefix("<COM:0") {
            NSLog("中控卡注册失败！")
            self.common.showAlertView(mes: LanguageHelper.shareInstance.getAppStr(key: "ControlCardRegistrationFailed"), controller: secondViewController)
        }
        //接收文件完成
        if readClientDataString!.hasSuffix("#Project:End") {
            NSLog("write xml completed!")
            
            startXML = false
            SendData(socket:sock,str: "#Project:End\r")
            //下载成功保存工程名
            dao.updateProjectTime(key: key_projectName, time: ProjectName)
            mainQueue.async(execute: {
                NotificationCenter.default.post(name: notification_downloadCompleted, object: nil)
            })
            //保存工程的更新时间
            dao.updateProjectTime(key: ProjectName, time: common.getCurrentTimeStr())
            DataCont = 0
            //每次读完数据后，都要调用监听数据的方法，否则只能接收一次数据
            sock.readData(withTimeout: -1, tag: 0)
            return
        }
        //接收文件中断
        if readClientDataString!.hasSuffix("#Project:Break") {
            NSLog("write xml stop!")
        
            startXML = false
            xmlH.deleteFile(fileName: ProjectName)
            mainQueue.async(execute: {
                NotificationCenter.default.post(name: notification_downloadStop, object: nil)
            })
            DataCont = 0
            //每次读完数据后，都要调用监听数据的方法，否则只能接收一次数据
            sock.readData(withTimeout: -1, tag: 0)
            return
        }
        //开始接收文件
        if readClientDataString!.hasPrefix("#Project:") {
            mainQueue.async(execute: {
                //发送开始接收工程文件的通知
                NotificationCenter.default.post(name: notification_downloadStart, object: nil)
            })
            print("开始接收工程文件")
            startXML = true
            ProjectName = readClientDataString?.substring(from: 9)
            xmlH.deleteFile(fileName: ProjectName)
            xmlH.createFile(fileName: ProjectName)
            
            DataCont = 0
            //每次读完数据后，都要调用监听数据的方法，否则只能接收一次数据
            sock.readData(withTimeout: -1, tag: 0)
            return
        }
        
        if startXML {
            //写数据入工程文件
            xmlH.writeXml(receivedString: readClientDataString!)
            //3. 处理请求，返回数据给服务端
//            mainQueue.asyncAfter(deadline: DispatchTime.now()+1) {
//                self.SendData(str: "DataCount:\(String(describing: readClientDataString!.length))\r")
                print("DataCount:\(String(describing: readClientDataString!.length))\r\n")
//            }
            DataCont = Int32(readClientDataString!.length/1000) + DataCont
            print("接收到数据大小:\(DataCont)K")
        }
        //每次读完数据后，都要调用监听数据的方法，否则只能接收一次数据
        sock.readData(withTimeout: -1, tag: 0)
    }

    func disConnect() {
        if self.clientSocket != nil {
            self.clientSocket.disconnect()
        }
        
    }

    


    
    
}
