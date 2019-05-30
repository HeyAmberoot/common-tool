//
//  OpacityAnimationViewController.swift
//  AnimationDemo
//
//  Created by xww on 2019/4/25.
//  Copyright © 2019年 cuanbo. All rights reserved.
//

import UIKit

class OpacityAnimationViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func btnReturnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.6) {
            self.opacityAnimation()
        }
        
    }
    
    func opacityAnimation() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = 5.0
        animation.repeatCount = HUGE
        self.imageView.layer.add(animation, forKey: "Image-opacity")
        self.imageView.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
