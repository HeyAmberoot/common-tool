//
//  main.swift
//  leanSwift
//
//  Created by amberoot on 17/6/27.
//  Copyright © 2017年 amberoot. All rights reserved.

//  swift3.0

import Foundation

print("Hello, World!")

//单行注释

/*
    /*
    可嵌套都多行注释
    */
*/

//变量
var myVariable = 42 //编译器自动推导其类型为Int
myVariable = 60 //变量多次赋值时需要保证值的类型相同
print(myVariable)

//常量
let myConstant = 0	//常量的值不能被二次修改

//swift不会自动给变量赋予初始值，所以必须给变量初始化
//let noValue   // 错误


//命名规则：可以使用Unicode。但不能含有数学符号、箭头、无效的Unicode、横线和制表符	，且不能以数字开头
let π = 3.14
var 你好 = "amberoot"
var 😄 = "哈哈"
let 狗狗 = "🐶🐶"
print(π,你好,😄,狗狗)

//整型写法///////////////////////////////////////////
let int1 = 17       //十进制
let int2 = 0b10001  //二进制
let int3 = 0o21     //八进制
let int4 = 0
