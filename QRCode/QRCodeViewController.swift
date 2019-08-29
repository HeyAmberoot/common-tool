//
//  QRCodeViewController.swift
//
//  Created by xww on 2018/11/19.
//  Copyright © 2018年 amberoot. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController ,UITabBarDelegate{

    
    @IBOutlet weak var viewContrainer: UIView!
    
    @IBOutlet weak var tabBarQRCode: UITabBar!
    
    @IBOutlet weak var imageViewQRCode: UIImageView!
    
    @IBOutlet weak var imageViewScanLine: UIImageView!
    
    @IBOutlet weak var constraintFrameHeight: NSLayoutConstraint!
    
    @IBOutlet weak var constraintScanLine: NSLayoutConstraint!
    
    @IBAction func btnCloseClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnPickPhotoClick(_ sender: Any) {
        //判断设置是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = .photoLibrary
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        }else{
            print("读取相册错误")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.设置底部视图默认选中第0个
        tabBarQRCode.delegate = self
        tabBarQRCode.selectedItem = tabBarQRCode.items?[0]
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imageViewScanLine.tintColor = UIColor.blue
        // 扫描二维码动画
        startAnimation()
        //开始扫描
        startScan()
        
    }
    
    ///扫描二维码
    private func startScan()
    {
        //1. 判断输入是否能够添加到会话中
        if !session.canAddInput(deviceInput!)
        {
            return
        }
        //2. 判断输出是否能够添加到会话中
        if !session.canAddOutput(output)
        {
            return
        }
        //3. 将输入和输出添加到会话中
        session.addInput(deviceInput!)
        session.addOutput(output)
        //print(output.metadataObjectTypes)
        //4. 设置输出能够解析的数据类型
        //注意:设置能够解析的数据类型时一定要在输出对象添加到会员之后设置，否则会报错
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        //5. 设置输出对象的代理，只要解析成功就会通知代理
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        //6. 添加预览图层
        view.layer.insertSublayer(PreviewLayer, at: 0)
        //6.2 添加绘制图层到预览图层
        PreviewLayer.addSublayer(drawLayer)
        
        //7. 告诉session开始扫描
        session.startRunning()
        
    }
    
    ///执行动画
    private func startAnimation()
    {
        //约束从顶部开始
        self.constraintScanLine.constant = -self.constraintFrameHeight.constant + 20
        self.imageViewQRCode.layoutIfNeeded()
        
        // 执行扫描条动画        
        UIView.animate(withDuration: 2.0) {
            //修改约束
            self.constraintScanLine.constant = 10
            //设置动画指定次数
            UIView.setAnimationRepeatCount(MAXFLOAT)
            //强制更新画面,要更新图片的容器视图而不是更新图片自身！！！！
            //self.imageViewScanLine.layoutIfNeeded()
            self.viewContrainer.layoutIfNeeded()
        }
        
    }
    
    //MARK: - UITabBarDelegate
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //1. 修改容器高度
        if item.tag == 0
        {
            print("二维码")
            self.constraintFrameHeight.constant = 250
        }else{
            print("条形码")
            self.constraintFrameHeight.constant = 125
        }
        //2. 停止动画
        //self.scanLineView.layer.removeAllAnimations()
        self.imageViewQRCode.layer.removeAllAnimations()
        //3. 重新开始动画
        startAnimation()
        
    }
    
    //MARK: - 懒加载
    ////////////////扫描二维码步骤///////////////////
    ///1.会话
    private lazy var session = AVCaptureSession()
    
    ///2.拿到输入设备
    private lazy var deviceInput:AVCaptureDeviceInput? = {
        //2.1 获取摄像头
//        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaType.video)
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        do{
            //2.2 创建输入对象
            let input = try AVCaptureDeviceInput(device: device!)
            return input
        }catch{
            print(error)
            return nil
        }
    }()
    ///3.拿到输出对象
    private lazy var output:AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    ///4. 创建预览图层
    lazy var PreviewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        layer.frame = UIScreen.main.bounds
        return layer
    }()
    
    ///5. 创建用于绘制边框的图层
    lazy var drawLayer:CALayer = {
        let layer = CALayer()
        layer.frame = UIScreen.main.bounds
        return layer
    }()
    
    
    
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
