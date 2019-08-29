//
//  coreDataDemo.swift
//  learnCoreData
//
//  Created by xww on 2019/3/12.
//  Copyright © 2019年 amberoot. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class coreDataDemo {
    
    
    func insertData() {
        //获取管理的数据上下文 对象
        let app = UIApplication.shared.delegate as! AppDelegate
        //获取管理的数据上下文
        let context = app.persistentContainer.viewContext
        
        //创建User对象
        let user = NSEntityDescription.insertNewObject(forEntityName: "User",into: context) as! User
        //对象赋值
        user.id = 1
        user.name = "amberoot"
        user.password = "12346"
        
        //保存
        do {
            try context.save()
            print("保存成功！")
        } catch {
            fatalError("不能保存：\(error)")
        }
    }
    
    func getData() {
        //获取管理的数据上下文 对象
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //声明数据的请求
        let fetchRequest = NSFetchRequest<User>(entityName:"User")
        fetchRequest.fetchLimit = 10 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //设置查询条件
        let predicate = NSPredicate(format: "id= '1' ", "")
        fetchRequest.predicate = predicate
        
        //查询操作
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            
            ///遍历查询的结果///
            for info in fetchedObjects{
                print("id=\(info.id)")
                print("username=\(info.name!)")
                print("password=\(info.password!)")
            }
            
            ///修改数据///
            for info in fetchedObjects{
                //修改密码
                info.password = "abcd"
                //重新保存
                try context.save()
            }
            
            ///删除数据///
            for info in fetchedObjects{
                //删除对象
                context.delete(info)
            }
            //重新保存-更新到数据库
            try! context.save()
            
        }
        catch {
            fatalError("不能保存：\(error)")
        }
    }
    

    
}

