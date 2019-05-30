//
//  SuccessivelySendOrder.swift
//  WisRoomGDiOS
//
//  Created by xww on 2019/4/18.
//  Copyright © 2019年 cuanbo. All rights reserved.
//

import Foundation

///把要发送的指令存在CmdStrArray逐条发送，每条指令相对应是否是16进制发送（isHexArray），还有延时多久发送下一条（DelayArray）
class SendOrder {
    
    public static let sharedInstance: SendOrder = SendOrder()
    
    var isHexArray = [String]()
    var CmdStrArray = [String]()
    var DelayArray = [Float]()
//    var isSendOver = false
    let soc = TCP_GCDAsyncSocket.sharedInstance
    let strHelper = StrHandler.sharedInstance
    
    ///循环发送指令
    public func roundSendOrder(roundTimes: Int, roundInterval: Float, codeArray: NSArray) {
       let interval = TimeInterval(roundInterval)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+interval) {
            self.sendOrder(codeArray)
        }
    }
    ///codeArray:[[cmd,hex,delay],[cmd2,hex2,delay2]]
    public func sendOrder(_ codeArray: NSArray) {
        //清除之前没发完的指令
        isHexArray.removeAll()
        CmdStrArray.removeAll()
        DelayArray.removeAll()
        //添加新的指令
        let codeNum = codeArray.count
        for codeIndex in 0 ..< codeNum {
            let sigleCode: NSArray!
            sigleCode = codeArray[codeIndex] as! NSArray
            
            let CmdStr = sigleCode[0] as! String
            let isHex = sigleCode[1] as! String
            let Delay = sigleCode[2] as! String
                
            var delayTime = Float(Delay)!/1000
            if delayTime == 0 {
                delayTime = 0.6
            }
                
            isHexArray.append(isHex)
            CmdStrArray.append(CmdStr)
            DelayArray.append(delayTime)
        }
       SendOrderToDevice()
        
    }
    
    ///发送指令到设备
    private func SendOrderToDevice() {
        if !soc.ConnectSucced {
            return
        }
        let delayTime = TimeInterval(DelayArray[0])
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+delayTime, execute: {
            if self.CmdStrArray.count != 0 && self.isHexArray.count != 0 {
                let order = self.CmdStrArray[0]
                
                if self.isHexArray[0] == "False" {
                    self.soc.SendData(str: order)
                }else {
                    var bytes = self.strHelper.strHexToByte(str: order)
                        bytes.append(0x0D)
                    self.soc.SendData(socket:self.soc.clientSocket, byte: bytes)
                        
                }
                self.SendOrderToDevice()
                self.CmdStrArray.remove(at: 0)
                self.isHexArray.remove(at: 0)
                self.DelayArray.remove(at: 0)
                
            }
        })
        
    }
    
}


