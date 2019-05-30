//
//  main.swift
//  leanSwift
//
//  Created by amberoot on 17/6/27.
//  Copyright © 2017年 cuanbo. All rights reserved.

//  swift3.0

import Foundation


//整型写法///////////////////////////////////////////
let int1 = 17       //十进制
let int2 = 0b10001  //二进制
let int3 = 0o21     //八进制
let int4 = 0x11     //十六进制


//字符串格式化，使用\(item)///////////////////////////////////////////
let apples = 6
let oranges = 8
let applesSummary = "i have \(apples) apples"
let fruitSummary = "\(apples + oranges) fruit"
print(applesSummary,"and",fruitSummary)

//类型转换///////////////////////////////////////////
let lable = "the width is"
let val = 66
let lableWidth = lable + String(val)//swift不支持隐式类型转换，需显式转换

//字符
let money :Character = "¥"
let face:Character = "😗"
print("\(money) \(face)")

/*
字符串常量包含的特殊字符：
空字符\0，反斜杠\，制表符\t，换行符\n，回车符\r，双引号\"，单引号\'
*/

//字符计数
let countstr = "wo shi sha sha de "
print("count's count is \(countstr.characters.count)")//算上空格
//print("count's count is \(countElements(countstr))")


/////////////String///////////////////////////////
var str00 = "i am string"
let str01 = ""
let str02 = "我是字符串"
//判断字符串是否为空
str00.isEmpty
str01.isEmpty
//获取字符串字符数量
str01.characters.count
str00.characters.count
str02.characters.count
//检查字符串是否含有特定的前缀/后缀
str00.hasPrefix("i")
str00.hasSuffix("i")
str02.hasSuffix("串")
//大小写字母转换
str00.uppercased()
str00.lowercased()
str02.uppercased()//中文进行大小写转换不起作用
str00.capitalized

//字符串截取
(str00 as NSString).substring(to: 4)//留下字符串前4个字母
(str00 as NSString).substring(from: 4)//不要前4个字母
(str00 as NSString).substring(with: NSMakeRange(2, 2))

//去除字符串最后的字母或首字母
let index0 = str00.index(before: str00.endIndex)
let index1 = str00.index(after: str00.startIndex)
str00.remove(at:index0)
str00.remove(at: index1)

//获取某个子串在父串中的范围
str00.range(of: "am")

//字符串转为数组
let str3 = "10:20:c:d:e"
let result = str3.components(separatedBy:":")

//指定范围内的字符串替换为其他字符串,将cde替换成m,使输出结果为abmfghi
let str4 = "abcdefghi"
let startIndex = str4.index(str4.startIndex, offsetBy:2)
let endIndex = str4.index(startIndex, offsetBy:3)
let result4 = str4.replacingCharacters(in: startIndex..<endIndex, with:"m")

///16进制字符串转十进制数
func strHexToInt() {
    let str = "3E 49 52"
    let strArray = str.components(separatedBy: " ")
    var byte:UInt32 = 0
    //
    for i in 0 ..< strArray.count {
        let ok = Scanner(string: strArray[i]).scanHexInt32(&byte)
        if ok {
            //若转十进制成功
            print(byte)
        }
    }
    
}

//string转换成为Int8
func stringToInt(str: String) -> Array<Int8> {
    let nsStr:NSString = str as NSString
    var arr = Array<Int8>()
    
    for i in 0 ..< str.characters.count {
        let int8:Int8 = nsStr.utf8String![i] //result = 99
        
        arr.append(int8)
    }
    return arr
}

//Int转16进制字符串
var hexStr = String().appendingFormat("%x",16)
//Int转8进制字符串
var octStr = String().appendingFormat("%o",16)
