//
//  LanguageHelper.swift
//
//  Created by amberoot on 17/8/24.
//  Copyright © 2017年 amberoot. All rights reserved.
//

import UIKit

class LanguageHelper: NSObject {
    //单例
    static let shareInstance = LanguageHelper()
    
    let def = UserDefaults.standard
    var bundle : Bundle?
    
    ///根据用户设置的语言类型获取字符串
    func getUserStr(key: String) -> String
    {
         // 获取本地化字符串，字符串根据手机系统语言自动切换
        let str = NSLocalizedString(key, comment: "default")
        return str
    }
    ///根据app内部设置的语言类型获取字符串
    func getAppStr(key: String) -> String
    {
        // 获取本地化字符串，字符串会根据app系统语言自动切换
        let str = NSLocalizedString(key, tableName: "Localizable", bundle: LanguageHelper.shareInstance.bundle!, value: "default", comment: "default")
        return str
    }
    
    ///设置app语言环境
    func setLanguage(langeuage: String) {
        var str = langeuage
        //如果获取不到系统语言，就把app语言设置为首选语言
        if langeuage == "" {
            //获取系统首选语言顺序
            let languages:[String] = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
            let str2:String = languages[0]
            //如果首选语言是中文，则设置APP语言为中文，否则设置成英文
            if ((str2=="zh-Hans-CN")||(str2=="zh-Hans"))
            {
                str = "zh-Hans"
            }else
            {
                str="en"
            }
            
        }
        //语言设置
        def.set(str, forKey: "langeuage")
        def.synchronize()
        let path = Bundle.main.path(forResource:str , ofType: "lproj")
        bundle = Bundle(path: path!)
 
    
    }
}
