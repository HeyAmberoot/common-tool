//
//  StringHandler.swift
//  8BC
//
//  Created by xww on 2019/3/20.
//  Copyright © 2019年 cuanbo. All rights reserved.
//

import Foundation

class StringHandler {
    //单例var计，防止创建多个对象
    public static let sharedInstance: StringHandler = StringHandler()
    
    ///检查字符串中是否含有中文字符
    func isIncludeChineseIn(string: String) -> Bool {
        
        for (_, value) in string.enumerated() {
            
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    
    ///16进制字符串转byte
    func strHexToByte(str: String) -> [UInt8] {
        let strArray = str.components(separatedBy: " ")
        var uint32:UInt32 = 0
        var byte = UInt8()
        var bytes = [UInt8]()
        //16进制字符串转十进制数
        let ok = Scanner(string: strArray[0]).scanHexInt32(&uint32)
        if ok {
            //若转十进制成功
            print(uint32)
            //Int转16进制字符
            //            let d = String().appendingFormat("%x",int)
            //let int = uint32.hashValue
            byte = UInt8(uint32)
            print(byte)
            bytes.append(byte)
        }
        return bytes
    }
    
    ///string转换成为Int8
    func strToInts(str: String) -> Array<Int8> {
        let nsStr:NSString = str as NSString
        var arr = Array<Int8>()
        
        for i in 0 ..< str.count {
            let int8:Int8 = nsStr.utf8String![i] //result = 99
            
            arr.append(int8)
        }
        return arr
    }
    
    ///16进制数组[UInt8]转字符串->如 01 10 CD 转成String "0110CD"
    func UInt8ToStr(bytes:[UInt8]) -> String {
        var hexStr = ""
        for index in 0 ..< bytes.count {
            var Str = bytes[index].description
            if Str.count == 1 {
                Str = "0 "+Str;
            }else {
                let low = Int(Str)!%16
                let hight = Int(Str)!/16
                Str = hexIntToStr(HexInt: hight) + hexIntToStr(HexInt: low)
            }
            hexStr += Str
        }
        return hexStr
    }
    
    func hexIntToStr(HexInt:Int) -> String {
        var Str = ""
        if HexInt>9 {
            switch HexInt{
            case 10:
                Str = "A"
                break
            case 11:
                Str = "B"
                break
            case 12:
                Str = "C"
                break
            case 13:
                Str = "D"
                break
            case 14:
                Str = "E"
                break
            case 15:
                Str = "F"
                break
            default:
                Str = "0"
            }
        }else {
            Str = String(HexInt)
        }
        
        return Str
    }

    
    ///获取设备uuid
    func getUUID() -> String{
        //swift3
        //let uuid = UIDevice.current.identifierForVendor?.uuidString
        let uuid = ""
        print("-----\(uuid)---------")
        return uuid
    }
    
    ///获取当前时间的字符
    func getCurrentTimeStr() ->String {
        let date = NSDate()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"//"yyyy-MM-dd HH:mm:ss.SSS"
        let strCurrentTime = timeFormatter.string(from: date as Date)
        
        
        return strCurrentTime
    }
    
}












