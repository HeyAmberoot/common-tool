//
//  xmlHelper.swift
//
//  Created by xww on 17/12/15.
//  Copyright © 2017年 amberoot. All rights reserved.
//

import Foundation

class xmlHelper {
    
    //单例设计，防止创建多个order对象
    public static let sharedInstance: xmlHelper = xmlHelper()
    let dao = DAO.sharedInstance

    let fileManager = FileManager.default
    
    ///存放XML文件的路径
    let xmlPath: String! = NSHomeDirectory() + "/Documents/"//"Users/mac/Desktop/"//Bundle.main.path(forResource: "demo", ofType: "xml")!//
    
    
    ///获取信息
    func readXML() -> Bool {
        //获取xml文件路径
//        let file = Bundle.main.path(forResource: "Project1", ofType: "xml")
        ProjectName = dao.readProjectTime(key: key_projectName)
        let url = URL(fileURLWithPath: xmlPath!+"\(ProjectName!).xml")////"Project.xml")
        //获取xml文件内容
        let xmlData = try? Data(contentsOf: url)
        //print(String(data:xmlData, encoding:String.Encoding.utf8))
        if xmlData == nil {
            NSLog("解析XML失败！")
            return false
        }
        do {
        //构造XML文档
        let doc = try DDXMLDocument(data: xmlData!, options:0)
          
        //利用XPath来定位节点（XPath是XML语言中的定位语法，类似于数据库中的SQL功能）
        let project = try! doc.nodes(forXPath: "//Project") as! [DDXMLElement]
        
        for user in project {
            //获取节点属性
//            let ProjectName = user.attribute(forName: "ProjectName")!.stringValue
            //获取节点内容
            //            let uname = user.forName("name")!.stringValue
            let SystemPage = user.forName("SystemPage")! as DDXMLElement
            
            /////获取子节点////////////
            let Devices = user.forName("Devices")! as DDXMLElement
            getInfo(element: Devices)
        }
            return true
        }catch {
            NSLog("解析XML失败！error:\(error)")
            return false
        }
    }
    
    func getInfo(element: DDXMLElement) {
        if devicesDict.count != 0 {
            devicesDict.removeAllObjects()
        }
        
        ///获取节点属性
        let Count = element.attribute(forName: "Count")?.stringValue
        let DeviceNum:Int = Int(Count!)!
        print("Project have \(DeviceNum) devices.")
        for device_index in 0 ..< DeviceNum {
            /////获取子节点device////////////
            let device:DDXMLElement? = element.forName("Device\(device_index)")
            ///获取节点device属性
            let IP = device?.attribute(forName: "IP")?.stringValue
            let Port = device?.attribute(forName: "Port")?.stringValue
            let FirstPage = device?.attribute(forName: "FirstPage")?.stringValue
            
            StartUpUID = (device?.attribute(forName: "StartUpUID")?.stringValue)!
            
        }
    }
}


    ///把XML数据写入文件
    func writeXml(receivedString: NSString) {

        //把字符串写进文件
        let str = receivedString as String
        let wr = NSMutableData();
        wr.append(str.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!)
        
        let manager = FileManager.default
        let urlsForDocDirectory = manager.urls(for:.documentDirectory, in:.userDomainMask)
        let docPath = urlsForDocDirectory[0]
        let file = docPath.appendingPathComponent("\(ProjectName!).xml")

        let writeHandler = try? FileHandle(forWritingTo:file)
        if writeHandler != nil {
            writeHandler!.seekToEndOfFile()
            writeHandler?.write(wr as Data)
            NSLog("writing xml")
        }
        
        
    }
    
    
    ///创建文件
    func createFile(fileName: String) {
//        let dbexits = fileManager.fileExists(atPath: xmlPath)        
//        if !dbexits {
            //新建xml文件
            fileManager.createFile(atPath: xmlPath+"\(fileName).xml", contents: nil, attributes: nil)
        print("新建系统文件")
//        }
        
    }
    
    ///删除文件
    func deleteFile(fileName: String?) {
        if fileName == nil {
            return
        }
        let dbexits = fileManager.fileExists(atPath: xmlPath+"\(fileName!).xml")
        if dbexits {
            try! fileManager.removeItem(atPath: xmlPath+"\(fileName!).xml")
            print("删除系统文件")
        }
    }
    
    func isFileExit() -> Bool {
        fileName = dao.readProjectTime(key: key_projectName)
        var exits = false
        if fileName != nil {
            exits = fileManager.fileExists(atPath: xmlPath!+"\(fileName!).xml")
        }
        return exits
    }

    
}


