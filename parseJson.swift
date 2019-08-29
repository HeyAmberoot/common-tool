//
//  parseJson.swift
//
//  Created by xww on 17/10/10.
//  Copyright © 2017年 amberoot. All rights reserved.
//


class Json {
    
    //单例设计，防止创建多个order对象
    public static let sharedInstance: Json = Json()
    
    ///存放Json文件的路径
    let JsonPath: String! = NSHomeDirectory() + "/Documents/demo.json"//"Users/mac/Desktop/demo.json"//
    //工程中文件路径//Bundle.main.path(forResource: "demo", ofType: "json")!//
    
    
    ///获取json信息
    func GetInfo(str: String) {
        //1.从文件中读取json
//        let jsonData = NSData(contentsOfFile: JsonPath)
        //2.解析json字符串
        let jsonData = str.data(using: String.Encoding.utf8)
        if jsonData == nil {
            return
        }
        do {
            //把Data对象转换回JSON对象,字典
            let json = try? JSONSerialization.jsonObject(with: jsonData! as Data,options:.allowFragments) as! [String: Any]
        } catch error {
            print(error)
        }
        
        //验证JSON对象可用性
        if json == nil {
            return
        }
        
    }
    
    
    var halfStr = ""
    var fullStr = ""
    func writeJson(receivedString: NSString) {

        //判断字符串是不是完整
        if (!receivedString.hasSuffix("}}") && !receivedString.hasSuffix("}\n}")) {
            NSLog("Is not a completed data")
            halfStr = halfStr + (receivedString as String)
            return
        }
        if halfStr != "" {
            fullStr = halfStr + (receivedString as String)
            halfStr = ""
        }else {
            fullStr = receivedString as String
        }
        NSLog("received json data")
//        let wr = NSMutableData();
//        wr.append(fullStr.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!)
//        
//        let bo = wr.write(toFile: JsonPath, atomically: true)
//        if bo == true {
//            NSLog("json write succeed")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                self.GetInfo(str: self.fullStr)
            }
//        }
//        else {
//            NSLog("json write fail")
//        }
    }
    
    
    ///初始化json文件
    func createJsonFile() {
        let fileManager = FileManager.default
        let dbexits = fileManager.fileExists(atPath: JsonPath)
        
        if !dbexits {
            //新建json文件
            fileManager.createFile(atPath: JsonPath, contents: nil, attributes: nil)
        }
        
    }


}
