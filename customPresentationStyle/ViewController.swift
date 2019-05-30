//
//  sceneVCExtension_CollectionView.swift
//  CBMvp
//
//  Created by xww on 17/10/16.
//  Copyright © 2017年 cuanbo. All rights reserved.
//

import Foundation
import UIKit

class ViewController {
    

            let storyboard = UIStoryboard(name: "StoryboardName", bundle: nil)
//            let scene = storyboard.instantiateViewController(withIdentifier: "Storyborad")
            let controller = storyboard.instantiateInitialViewController()
            let animator = PopAnimator()
            controller?.transitioningDelegate = animator
            controller?.modalPresentationStyle = .custom
            self.view.window?.rootViewController?.present(controller!, animated: true, completion: nil)
            
    


    
}
    
    
