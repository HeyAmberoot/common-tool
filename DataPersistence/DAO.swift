//
//  DAO.swift
//  example
//
//  Created by xww on 17/8/3.
//  Copyright © 2017年 amberoot. All rights reserved.
//

import Foundation


class DAO {
    
    
    
    //私有的DateFormatter属性
    private var dateFormatter = DateFormatter()
    //私有的沙箱目录中属性列表文件路径
    private var plistFilePath: String!
    //NSHomeDirectory:应用所存储的目录
    private var localPlistPath:String! = NSHomeDirectory() + "/Documents/localData.plist"

    //单例设计，防止创建多个DAO对象
    public static let sharedInstance:DAO = {
        let instance = DAO()
        
        //初始化沙箱目录中的属性列表文件路径
        //instance.plistFilePath = instance.applicationDocumentsDirectoryFile()
        //初始化dateFormatter
        instance.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //初始化属性列表文件
        instance.createEditableCopyOfDatabaseIfNeeded()
        //初始化字典
        instance.create()
        
        
        return instance
    }()
    
    //初始化属性列表文件
    func createEditableCopyOfDatabaseIfNeeded() {
        let fileManager = FileManager.default
        let dbexits = fileManager.fileExists(atPath: self.localPlistPath!)
        
        if !dbexits {
            //网上的方法
            fileManager.createFile(atPath: self.localPlistPath, contents: nil, attributes: nil)
            //书里的方法
//            let frameworkBundle = Bundle(for: DAO.self)
//            let frameworkBundlePath = frameworkBundle.resourcePath! as NSString
//            let defaultDBPath =           frameworkBundlePath.appendingPathComponent("NotesList.plist")
            
//            do{
//                try fileManager.copyItem(atPath: defaultDBPath, toPath: self.plistFilePath)
//            }catch {
//                print(error)
//                assert(false,"错误写入文件")
//                
//            }
            
        }
    }
    
    //没有参数但有返回值的方法可设计成‘计算属性“
//    func applicationDocumentsDirectoryFile() -> String {
//        let documentDirectory:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
//        let path = (documentDirectory[0] as AnyObject).appendingPathComponent("NotesList.plist") as String
//        return path
//        
//    }
    let applicationDocumentsDirectoryFile: String = {
        let documentDirectory:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let path = (documentDirectory[0] as AnyObject).appendingPathComponent("NotesList.plist") as String
        return path
        }()
    
    //插入数据
    func create() {
        //设置root
        let rootDict = NSMutableDictionary()
        //设置boolean
        rootDict.setValue(true, forKey: "key_Boolean")
        //设置array
        rootDict.setValue(["one","two"], forKey: "key_Array")
        //设置numberInt
        rootDict.setValue(1, forKey: "key_Int")
        //设置numberFloat
        rootDict.setValue(1.2, forKey: "key_Float")
        //设置dictionary
        rootDict.setValue(["key1":"value1","key2":"value2"], forKey: "key_Dictionary")
        //设置date
        rootDict.setValue(NSDate(), forKey: "key_Date")//
        
        //将root写入.plist文件
        rootDict.write(toFile: self.localPlistPath, atomically: true)

    }
    
    ///读取Plist文件中的数据（可以是String\Int\Array\Dictioary\Date，不能读取元组tuples）
    func readDao(key:String) -> Any {
        let rootDict = NSMutableDictionary(contentsOfFile: self.localPlistPath)
        let strTime = rootDict?[key] as Any
        
        return strTime
    }
    ///更新Plist文件中的数据
    func updateDao<T>(key:String, data:T) {
        let rootDict = NSMutableDictionary(contentsOfFile: self.localPlistPath)
        rootDict?.setValue(data, forKey: key)
        rootDict?.write(toFile: self.localPlistPath, atomically: true)
    }
    
    //删除数据
    func deleteByKey(key: String) {
        let rootDict = NSMutableDictionary(contentsOfFile: self.localPlistPath)
        rootDict?.removeObject(forKey: key)
        rootDict?.write(toFile: self.localPlistPath, atomically: true)

    }
    

    
    
    
    
}
