//
//  Observer.swift
//  KVO
//
//  Created by xww on 2019/2/14.
//  Copyright © 2019年 cuanbo. All rights reserved.
//

import Foundation

//NSObject类实现了NSKeyValueOberving协议，只需继承NSObject类即可
class MyObserver: NSObject {
    
    //观察属性值
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        NSLog("\(keyPath!)--\(change![NSKeyValueChangeKey.newKey] as! String)")
    }
}
