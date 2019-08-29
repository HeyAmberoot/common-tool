//
//  ColorCustom.swift
//
//  Created by xww on 2019/4/18.
//  Copyright © 2019年 amberoot. All rights reserved.
//

import Foundation
import UIKit

class ColorCustom {
    
    //单例设计，防止创建多个CommonFunc对象
    public static let sharedInstance: ColorCustom = ColorCustom()
    
    ///Blue
    let Cyan = UIColor.init(red: 0/225, green: 255/225, blue: 255/225, alpha: 1)
    let LightBlue = UIColor.init(red: 176/225, green: 216/225, blue: 229/225, alpha: 1)
    let DodgerBlue = UIColor.init(red: 53/225, green: 128/225, blue: 220/225, alpha: 1)
    let DodgerBlue3 = UIColor.init(red: 24/225, green: 116/225, blue: 205/225, alpha: 1)
    let DodgerBlue4 = UIColor.init(red: 16/225, green: 78/225, blue: 139/225, alpha: 1)
    let LightSlateBlue = UIColor.init(red: 132/225, green: 112/225, blue: 255/225, alpha: 1)
    let SteelBlue = UIColor.init(red: 78/225, green: 129/225, blue: 179/225, alpha: 1)
    let Blue4 = UIColor.init(red: 0/225, green: 0/225, blue: 139/225, alpha: 1)
    let SlateBlue = UIColor.init(red: 106/225, green: 90/225, blue: 205/225, alpha: 1)
    let BlueViolet = UIColor.init(red: 138/225, green: 43/225, blue: 226/225, alpha: 1)
    let RoyalBlue1 = UIColor.init(red: 72/225, green: 118/225, blue: 225/225, alpha: 1)
    let RoyalBlue3 = UIColor.init(red: 58/225, green: 95/225, blue: 205/225, alpha: 1)
    let DarkCyan = UIColor.init(red: 33/225, green: 140/225, blue: 138/225, alpha: 1)
    let DeepSkyBlue = UIColor.init(red: 0/225, green: 191/225, blue: 255/225, alpha: 1)
    
    ///Red
    let LightCoral = UIColor.init(red: 240/225, green: 128/225, blue: 128/225, alpha: 1)
    let Coral1 = UIColor.init(red: 249/225, green: 110/225, blue: 90/225, alpha: 1)
    let OrangeRed = UIColor.init(red: 255/225, green: 69/225, blue: 0/225, alpha: 1)
    let Firebrick1 = UIColor.init(red: 249/225, green: 32/225, blue: 55/225, alpha: 1)
    let PaleVioletRed = UIColor.init(red: 219/225, green: 112/225, blue: 147/225, alpha: 1)
    let Red4 = UIColor.init(red: 139/225, green: 0/225, blue: 0/225, alpha: 1)
    let IndianRed = UIColor.init(red: 205/225, green: 92/225, blue: 92/225, alpha: 1)
    let DarkRed = UIColor.init(red: 139/225, green: 0/225, blue: 0/225, alpha: 1)
    let Maroon = UIColor.init(red: 176/225, green: 48/225, blue: 96/225, alpha: 1)
    let Maroon1 = UIColor.init(red: 255/225, green: 52/225, blue: 179/225, alpha: 1)
    ///Green
    let SpringGreen3 = UIColor.init(red: 42/225, green: 208/225, blue: 105/225, alpha: 1)
    let SpringGreen = UIColor.init(red: 54/225, green: 255/225, blue: 130/225, alpha: 1)
    let OliveDrab3 = UIColor.init(red: 154/225, green: 208/225, blue: 59/225, alpha: 1)
    let OliveDrab2 = UIColor.init(red: 179/225, green: 238/225, blue: 58/225, alpha: 1)
    let MedSpringGreen = UIColor.init(red: 0/225, green: 250/225, blue: 154/225, alpha: 1)
    let SpringGreen4 = UIColor.init(red: 0/225, green: 139/225, blue: 69/225, alpha: 1)
    let DarkGreen = UIColor.init(red: 0/225, green: 100/225, blue: 0/225, alpha: 1)
    let DarkSeaGreen = UIColor.init(red: 143/225, green: 188/225, blue: 143/225, alpha: 1)
    let DarkSeaGreen4 = UIColor.init(red: 105/225, green: 139/225, blue: 105/225, alpha: 1)
    let LightGreen = UIColor.init(red: 144/225, green: 238/225, blue: 144/225, alpha: 1)
    let LawnGreen = UIColor.init(red: 124/225, green: 252/225, blue: 0/225, alpha: 1)
    let SeaGreen3 = UIColor.init(red: 67/225, green: 205/225, blue: 128/225, alpha: 1)
    let ForestGreen = UIColor.init(red: 34/225, green: 139/225, blue: 34/225, alpha: 1)
    ///Orange/Yellow
    let Orange1 = UIColor.init(red: 250/225, green: 165/225, blue: 33/225, alpha: 1)
    let DarkOrange3 = UIColor.init(red: 205/225, green: 102/225, blue: 0/225, alpha: 1)
    let LightSalmon3 = UIColor.init(red: 205/225, green: 129/225, blue: 98/225, alpha: 1)
    let DarkGoldenrod4 = UIColor.init(red: 139/225, green: 101/225, blue: 8/225, alpha: 1)
    let Gold = UIColor.init(red: 255/225, green: 215/225, blue: 0/225, alpha: 1)
    let Tomato = UIColor.init(red: 255/225, green: 99/225, blue: 71/225, alpha: 1)
    let Goldenrod = UIColor.init(red: 218/225, green: 165/225, blue: 32/225, alpha: 1)
    let DarkGoldenrod1 = UIColor.init(red: 255/225, green: 185/225, blue: 15/225, alpha: 1)
    let LightGoldenrod3 = UIColor.init(red: 205/225, green: 190/225, blue: 112/225, alpha: 1)
    let Yellow3 = UIColor.init(red: 205/225, green: 205/225, blue: 0/225, alpha: 1)
    
    ///Purple
    let MediumPurple = UIColor.init(red: 149/225, green: 107/225, blue: 217/225, alpha: 1)
    let Orchid1 = UIColor.init(red: 255/225, green: 131/225, blue: 250/225, alpha: 1)
    let MediumOrchid = UIColor.init(red: 185/225, green: 75/225, blue: 209/225, alpha: 1)
    let Purple3 = UIColor.init(red: 125/225, green: 38/225, blue: 205/225, alpha: 1)
    let Purple = UIColor.init(red: 160/225, green: 32/225, blue: 240/225, alpha: 1)
    let Plum = UIColor.init(red: 221/225, green: 160/225, blue: 221/225, alpha: 1)
    ///Pink
    let PeachPuff = UIColor.init(red: 252/225, green: 218/225, blue: 186/225, alpha: 1)//桃色
    let DeepPink = UIColor.init(red: 255/225, green: 20/225, blue: 147/225, alpha: 1)
    let HotPink = UIColor.init(red: 255/225, green: 105/225, blue: 180/225, alpha: 1)
    let Thistle1 = UIColor.init(red: 221/225, green: 160/225, blue: 221/225, alpha: 1)
    ///Gray
    let DarkSlateGray = UIColor.init(red: 50/225, green: 79/225, blue: 79/225, alpha: 1)
    let Tan = UIColor.init(red: 210/225, green: 180/225, blue: 140/225, alpha: 1)
    
    ///Brown
    let SandyBrown = UIColor.init(red: 244/225, green: 164/225, blue: 96/225, alpha: 1)
    let RosyBrown = UIColor.init(red: 188/225, green: 143/225, blue: 143/225, alpha: 1)
    let Khaki1 = UIColor.init(red: 255/225, green: 246/225, blue: 143/225, alpha: 1)//卡其色1
    let DarkKhaki = UIColor.init(red: 189/225, green: 183/225, blue: 107/225, alpha: 1)
    let Sienna2 = UIColor.init(red: 238/225, green: 121/225, blue: 66/225, alpha: 1)
    let Sienna4 = UIColor.init(red: 139/225, green: 71/225, blue: 38/225, alpha: 1)
    

    
    
    
    
    
    
    
    
    
    
    
    
    
}
