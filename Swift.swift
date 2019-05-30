//
//  main.swift
//  leanSwift
//
//  Created by amberoot on 17/6/27.
//  Copyright © 2017年 cuanbo. All rights reserved.

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
let int4 = 0x11     //十六进制

let minValueU8 = UInt8.min
let minValue8 = Int8.min
let minValue16 = Int16.min
let maxValueU8 = UInt8.max
let maxValueU16 = UInt16.max
let maxValue_U16 = UINT16_MAX
let maxValue16 = INT16_MAX
let maxValueU32 = UInt32.max
let maxValue32 = Int32.max
print(minValueU8,minValue8,minValue16)
print(maxValueU8,maxValueU16,maxValue_U16,maxValue16,maxValueU32,maxValue32)


//类型别名///////////////////////////////////////////
typealias myInt = Int   //给Int取个别名叫myInt
var value:myInt = 45
value = 88
print(value)

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

///////////////////////////////////////////
//数组Array///////////////////////////////////////////
///////////////////////////////////////////
//let emptyArray1 = [] //声明一个空的数组
var emptyArray2 = [String]()   //创建一个特定数据类型的空数组
emptyArray2.append("eggs")
emptyArray2.append("milk")   //插入元素进数组的最后位置
emptyArray2.insert("oranges", at: 0)//指定位置插入元素进数组
print(emptyArray2)
print(emptyArray2.count)    //数组点个数
print(emptyArray2.capacity)//数组容量，其值大于等于count，并且是2点次方
print(emptyArray2.isEmpty)//判断数组是否为空

var array2 = [3,6,9,12]
//数组相加
var array3 = [Int]()
array3.append(8)
var array4 = array3 + array2   //可把两个相同数据类型的数组相加
print(array4)

//修改数组元素
array4[1...3] = [0,1,2,3,4,5,6,7,9]//把下标为1、2、3的元素替换成0，2；除了能替换值还能改变数组的个数
print(array4)

//删除数组元素
array4.removeLast()
print(array4)
array4.remove(at: 2)
print(array4)
array4.removeAll()
print(array4)

//数组的遍历
print(emptyArray2)
for item in emptyArray2 {
    print(item)
}

//数组的遍历2
//for (index,value) in EnumeratedSequence(emptyArray2){
//    print("item \(index + 1) : \(value) ")
//}

//创建一个带有默认值的数组
var threedouble = [Double]( repeating: 0.0,count: 3)
print(threedouble)  //[ 0.0 , 0.0 , 0.0 ]

var threedouble2 = Array( repeating: 1.0,count: 3)
print(threedouble2) //[ 1.0 , 1.0 , 1.0 ]

///////////////////////////////////////////
//dictionary 字典///////////////////////////////////////////
///////////////////////////////////////////
//var emptyDictionary1 = [:]   //声明一个空的字典
let emptyDictionary2 = Dictionary<String,Float>()//声明一个空的字典，key为String类型，value为Float类型
var airports = ["TYO":"Tokyo","DUB":"Dublin","white":"White Cloud Airport"]
print(airports)

//修改和添加字典元素
airports["TYO"] = "Tokyo international"//字典本来就有的key就修改
airports["beijing"] = "beijing aieport"//字典本来没有的key就添加
print(airports)

//删除字典元素
airports["beijing"] = nil
airports.removeValue(forKey: "TYO")
print(airports)

//输出count
print("airports count is \(airports.count)")
print("airports count is " + String(airports.count))

//字典遍历
for (key ,value) in airports {
    print(" \(key) : \(value)")
}

//遍历所有的key
for key in airports.keys {
    print(key)
}

//遍历所有的value
for value in airports.values {
    print(value)
}

let allKeys = Array(airports.keys)//把所有的key转换成数组
let allValues = Array(airports.values)//把所有的value转换成数组
print(allKeys,allValues)

///////////////////////////////////////////
//元组 tuple///可将任意数据类型组装成一个元素///////////
////////////////////////////////////
//元组创建1
let (x,y) = (1,2)   //定义一个简单的元组
print("x is \(x) and y is \(y)")
//元组创建2
let http404Error = (404,"not found")//定义一个由Int和 String组成的元组
print(http404Error)
//访问元组的值
let (statusCode, statusMessage) = http404Error
print("statusCode is \(statusCode) and statusMessage is \(statusMessage)")

let (onlyStatusCode, _) = http404Error//只取一个值，不用的值用下划线_表示

print(http404Error.0 ,http404Error.1)

//元组创建3
let http200Status = (statusCode: 200, desc: "OK")
print(http200Status.statusCode)
print(http200Status.desc)

/////////////////////////////////////////////////////
//可选类型  optional///////////////////
////////////////////////////////////////////////////

let possibleNumber = "123"
let convertedNumber:Int? = Int(possibleNumber)
let possibleNumber1 = "hello"
let convertedNumber1:Int? = Int(possibleNumber1)
print(convertedNumber,convertedNumber1)//结果：Optional(123) nil
//如果possibleNumber可转换成整形，convertedNumber存在，如果不可转换成整形convertedNumber的值不存在，即＝nil
//在swift里nil不能用于非可选类型

var str: String?
let hashValue = str?.hashValue//？的意思是询问可选量是否响应后面的方法
print(hashValue)


//解包可选类型 ！
//确定可选类型的值一定存在时，获取其属性要用！解包
let possibleString :String?=" i am amberoot "
print(possibleString!)//确认possibleString的值一定存在，不需要验证值是否存在
let StringValue = possibleString!.hashValue//确认possibleString的值一定存在，可获取其属性
//Optional Binding,等价于上面一行
if let sValue = possibleString {
    let StringValue = sValue.hashValue
}
print(StringValue)

//隐式解包的可选类型，直接在定义的时候加！
//用！代替？

////////////////////////////////////////
///范围运算符////////////////////////////////////////
////////////////////////////////////////

//闭区间运算符：a...b；定义一个范围，从a到b，并且包括a和b
for index in 1...5 {
    print(index)
}

//半开区间运算符：a..<b；定义一个范围，从a到b，包含a不包含b，包头不包尾
for index in 1..<5 {
    print(index)
}

////////////////////////////////////////
///字符与字符串////////////////////////////////////////
////////////////////////////////////////
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

//给Int取个别名叫myInt
typealias myInt12 = Int
var value12:myInt12 = 45
value12 = 88
print(value12)
//创建一个特定数据类型的空数组
var emptyArray12 = [Int]()
emptyArray12.append(6)
emptyArray12.append(9)
emptyArray12.insert(3, at: 1)

///////////where语句///////////////////
let scores = [20,8,59,60,70,80]
//switch语句中使用
scores.forEach {
    switch $0{
    case let x where x>=60:
        print("及格")
    default:
        print("不及格")
    }
}
scores.forEach { (x) in
    print(x)
}
//for语句中使用
for score in scores where score>=60 {
    print("这个是及格的：\(score)")
}

///////////在do catch中使用where语句///////////////////
enum ExceptionError:Error{
    case httpCode(Int)
}

func throwError() throws {
    throw ExceptionError.httpCode(500)
}

do{
    try throwError()
}catch ExceptionError.httpCode(let httpCode) where httpCode >= 500{
    print("server error")
}catch {
    print("other error")
}

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
(str00 as NSString).substring(to: 4)
(str00 as NSString).substring(from: 4)
(str00 as NSString).substring(with: NSMakeRange(2, 2))
//去除字符串最后的字母
str00.endIndex
str00.startIndex
let index0 = str00.index(before: str00.endIndex)
let index1 = str00.index(after: str00.startIndex)
str00.remove(at:index0)
print(str00)
str00.remove(at: index1)
print(str00)
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
func stringToHex() {
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

////////////////////////////////////////
///函数////////////////////////////////////////
////////////////////////////////////////

//函数声明
func sayHello(_ name: String) -> String {
    let geeting = "hi" + name + "!"
    return geeting
}
//函数调用
sayHello("amberoot")

//1.1函数可以有多个输入参数
func minusResult(_ started: Int, end: Int) -> Int {
    return end - started
}

let result00 = minusResult(3, end: 9)
print(result00)

//1.2 无参函数
func minusResult() -> Int {
    return 22
}

//1.3 无返回值函数。虽然没有定义返回值，但函数依然会返回Void，一个空的元组（tuple）,没有任何元素，写成（）
func sayGoodbye(_ name: String) {
    print(name)
}
sayHello("goodbey")

//1.4 多重返回值函数.返回类型是元组
func count(_ str:String) -> (vs:Int, cs: Int ,os: Int){
    return (1,2,3)
}

///外部参数
func join(s1:String,s2:String,joiner:String) ->String {
    return s1 + joiner + s2
}
print(join(s1:"hello", s2: "world", joiner: ","))

///默认参数值
/*
可以为函数中的每个参数设定默认值。默认值被定义后，调用函数时可以省略，也可以改写
*/
func join2(s1:String,s2:String,joiner:String = "-") ->String {
    return s1 + joiner + s2
}
let str1 = join2(s1:"hello", s2: "world", joiner: ",")
let str2 = join2(s1:"hello", s2: "world")
print(str2)
print(str1)

///可变参数
/*
函数调用时，用可变参数来传入不确定数量的输入参数.
一个函数最多只能有一个可变参数
可变参数必须放在参数表中最后的位置
*/
func total(_ numbers: Double...) -> Double{
    var total :Double = 0
    for number in numbers{
        total += number
    }
    return total / Double(numbers.count)
}
print(total(1.1,2.2,3.3))
print(total(1.1,2.2,3.3,4.4))

///常量参数与变量参数
func alightRight(_ str:String, count: Int, pad: Character) -> String{
    var str = str
    let amountToPad = count - str.characters.count
    for _ in 1...amountToPad {
        str = String(pad) + str
    }
    return str
}
let originalStr = "hello"
let paddedStr = alightRight(originalStr, count: 10, pad: "_")
print(originalStr)
print(paddedStr)

///输入输出参数.关键字 inout
//函数调用后仍然存在，而且可修改参数的值
func swapTwoInt(_ a:inout Int,b: inout Int){
    let temp = a
    a = b
    b = temp
}
 var someInt = 3
 var anotherInt = 7

swapTwoInt(&someInt, b: &anotherInt)
print(someInt,anotherInt)

////////////////////////////////////////////////////
///函数类型（是一种数据类型）
////////////////////////////////////////////////////
//分3步：1.定义函数；2.声明函数类型变量或常量；3.给函数类型变量赋值

//1.定义函数
func add(_ a:Int, b:Int) ->Int{
    return a + b
}

//2.声明函数类型变量，类型是(Int, Int) -> Int
var mathFunction:(Int, Int) -> Int

//3. 给函数类型变量赋值
mathFunction = add

//4.使用
print("Result: \(mathFunction(3,6))")

////////////////////////////////////////////////////
///函数类型作为返回类型
////////////////////////////////////////////////////
func StepForward(_ input:Int) ->Int{
    return input + 1
}
func StepBackward(_ input:Int) ->Int{
    return input - 1
}
func chooseStep(_ backward:Bool) -> (Int) ->Int{
    return backward ? StepBackward : StepForward    //返回函数类型
}

var currenValue = 3
let moreNearToZero = chooseStep(currenValue>0)
print("moreNearToZero:\(moreNearToZero)")
print("返回函数类型result:\(moreNearToZero(8))")

////////////////////////////////////////////////////
///嵌套函数
////////////////////////////////////////////////////

func chooseStep2(_ backward:Bool) -> (Int) ->Int{
    
    func StepForward2(_ input:Int) ->Int{
        return input + 1
    }
    
    func StepBackward2(_ input:Int) ->Int{
        return input - 1
    }
    
    return backward ? StepBackward : StepForward    //返回函数类型
}

var currenValue2 = -4
let moreNearToZero2 = chooseStep(currenValue2 > 0)
print("moreNearToZero2:\(moreNearToZero2)")
print("嵌套函数result:\(moreNearToZero2(8))")

////////////////////////////////////////////////////
///闭包
////////////////////////////////////////////////////
/*
可以使用常量、变量、inout类型、元组作为参数，不提供默认值
*/

///不使用闭包
let names = ["amber","victor","alice","alex","summer"]
func sortNames (_ s1:String,s2:String) -> Bool {
    return s1 > s2
}
var reversed = names.sorted(by: sortNames)
print(reversed)

///使用闭包
var reversed2 = names.sorted(by: {
    (s1:String,s2:String) -> Bool in
    return s1 > s2
    })
print(reversed2)

//根据上下文推断类型
reversed2 = names.sorted(by: {s1,s2 in return s1 > s2})

//单表达式闭包隐式返回(如果闭包体只有一个表达式，return关键字可以省略)
reversed2 = names.sorted(by: {s1,s2 in s1 > s2})

////////////////////////////////////////////////////
///捕获值
////////////////////////////////////////////////////
func makeIncrementor(forincrement amount: Int) -> ()->Int{
    var runningTotal = 0
    
    //incrementor()在函数体访问了runningTotal、amount变量。因为其通过捕获在包含他的函数体内已经存在的runningTotal、amount变量而实现
    func incrementor() -> Int{
        runningTotal += amount
        return runningTotal
    }
    
    return incrementor
}

let incrementByTen = makeIncrementor(forincrement: 10)

//因为每次调用该函数的时候都会修改runningTotal的值，incrementor捕获了当前runningTotal变量的引用，而不是仅仅复制该变量的初始值。捕获了一个引用保证了当makeIncrementor结束时候并不会消失，也保证了当下一次执行incrementor函数时，runningTotal可以继续增加
print(incrementByTen())
print(incrementByTen())
print(incrementByTen())

let incrementBySeven = makeIncrementor(forincrement: 7)
print(incrementBySeven())
