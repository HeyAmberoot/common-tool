//
//  ViewController.swift
//  KVO
//
//  Created by xww on 2019/2/14.
//  Copyright © 2019年 amberoot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //我们想要观察的属性
    @objc dynamic var controllerStatus:NSString!
    //观察者
    var oberver: MyObserver!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建观察者对象
        self.oberver = MyObserver()
        //开始观察controllerStatus属性变化
        self.addObserver(oberver, forKeyPath: "controllerStatus", options: [NSKeyValueObservingOptions.new,NSKeyValueObservingOptions.old], context: nil)
        
        self.controllerStatus = "viewDidLoad"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.controllerStatus = "viewDidAppear"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.controllerStatus = "viewWillAppear"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.controllerStatus = "viewDidLayoutSubviews"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.controllerStatus = "viewWillDisappear"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.controllerStatus = "viewDidDisappear"
    }

}

