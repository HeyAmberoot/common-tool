//
//  DAO.swift
//  example
//
//  Created by xww on 17/8/3.
//  Copyright © 2017年 amberoot. All rights reserved.
//

import Foundation

class fileHelper {
    
    
    ///创建文件
    func createFile(fileName: String) {
        
        fileManager.createFile(atPath: xmlPath+"\(fileName).xml", contents: nil, attributes: nil)
        
    }
    
    ///删除文件
    func deleteFile(fileName: String?) {
        if fileName == nil {
            return
        }
        let dbexits = fileManager.fileExists(atPath: xmlPath+"\(fileName!).xml")
        if dbexits {
            try! fileManager.removeItem(atPath: xmlPath+"\(fileName!).xml")
        }
    }

    ///读取文件中的数据
    func readFile(filePath: String) -> Bool {
        //获取文件路径
        //        let file = Bundle.main.path(forResource: "Project1", ofType: "xml")
        
        let url = URL(fileURLWithPath: filePath)
        //获取文件内容
        let datas = try? Data(contentsOf: url)
        //print(String(data:xmlData, encoding:String.Encoding.utf8))
        if datas == nil {
            NSLog("读取数据失败！")
            return false
        }
        return true
        
        
    }
    
    //把字符串写进文件,文件保存在沙盒中Documents路径中
    func writeStrToFile(receivedString: NSString) {
        
        let str = receivedString as String
        let wr = NSMutableData()
        wr.append(str.data(using:String.Encoding(rawValue: String.Encoding.utf8.rawValue))!)
        
        let manager = FileManager.default
        let urlsForDocDirectory = manager.urls(for:.documentDirectory, in:.userDomainMask)
        let docPath = urlsForDocDirectory[0]
        let file = docPath.appendingPathComponent("Demo.xml")
        let writeHandler = try? FileHandle(forWritingTo:file)
        if writeHandler != nil {
            writeHandler!.seekToEndOfFile()
            writeHandler?.write(wr as Data)
        }
        
        
    }
    
    ///获取指定路径中的所有文件名
    func getPathAllFileName(path:String) -> [String]{
        var fileNameArray:[String] = []
        do {
            fileNameArray = try FileManager.default.contentsOfDirectory(atPath: path)
            
        } catch let error as NSError {
            print("get file path error: \(error)")
        }
        
        return fileNameArray
    }
    
    ///获取指定路径中的所有xml文件
    func getPathAllXmlFile(path:String) -> [String]{
        var fileNameArray:[String] = []
        var xmlFileArray:[String] = []
        do {
            fileNameArray = try FileManager.default.contentsOfDirectory(atPath: path)
            for fileName in fileNameArray {
                if fileName.hasSuffix(".xml") {
                    var xmlFileName = fileName
                    for _ in 0 ..< 4 {
                        xmlFileName.remove(at:getStringLastIndex(str: xmlFileName))
                    }
                    
                    xmlFileArray.append(xmlFileName)
                }
            }
        } catch let error as NSError {
            print("get file path error: \(error)")
        }
        
        return xmlFileArray
    }

    
}
