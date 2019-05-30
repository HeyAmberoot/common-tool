//
//  ViewController.swift
//  AnimationDemo
//
//  Created by xww on 2019/4/24.
//  Copyright © 2019年 cuanbo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func btnPathAnimationClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "PathAnimation", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        self.view.window?.rootViewController?.present(controller!, animated: true, completion: nil)
    }
    
    @IBAction func btnOpacityClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "OpacityAnimation", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        self.view.window?.rootViewController?.present(controller!, animated: true, completion: nil)
    }
    
    @IBAction func btnSizeClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SizeAnimation", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        self.view.window?.rootViewController?.present(controller!, animated: true, completion: nil)
    }
    
    @IBAction func btnRadarAnimation(_ sender: Any) {
        let storyboard = UIStoryboard(name: "RadarAnimation", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        self.view.window?.rootViewController?.present(controller!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

