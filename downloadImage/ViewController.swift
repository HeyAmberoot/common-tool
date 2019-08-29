//
//  ViewController.swift
//
//  Created by xww on 2018/6/27.
//  Copyright © 2018年 amberoot. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIGestureRecognizerDelegate{

    @IBOutlet weak var tableViewTX: UITableView!
    
    @IBOutlet weak var tableViewRX: UITableView!
    
    @IBOutlet weak var collectionViewRX: UICollectionView!
    
    @IBAction func btnSettingClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Setting", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
//        let animator = PopAnimator()
//        controller?.transitioningDelegate = animator
//        scene?.modalPresentationStyle = .custom
//        self.view.window?.rootViewController?.present(scene!, animated: true, completion: nil)
        controller?.modalPresentationStyle = .formSheet
        self.view.window?.rootViewController?.present(controller!, animated: true, completion: nil)
        
    }
    
    
    
    let snapOperationsCollectionView = SnapOperations()
    let snapOperations = SnapOperations()
    ///保存从交换机接收到的TX数据
    var snapsTx = [SnapRecord]()
    ///保存从交换机接收到的RX数据
    var snapsRx = [SnapRecord]()
    ///保存CollectionView的RX数据
    var snapsRxCollectionView = [SnapRecord]()
    let socket_tcp = TCP_GCDAsyncSocket.sharedInstance
    let dao = DAO.sharedInstance
    let alert = AlertView.sharedInstance
    var timer = Timer()
    //手势拖动显示label-IP
    var labelIP = UILabel()
    var viewIP = UIView()
    var imgView = UIImageView()
    //保存tableview拖动cell数据
    var dragIP = ""
    var dragSnapRecord: SnapRecord!
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    ///是否有选中tableViewCell
    var isSelectCell = false
    ///collectionView列数
    var columeNum = 2
    ///collectionView行数
    var rowNum = 3
    ///根据IP保存图片需要截图用到的第几行和第几列
    var dicRxImage = NSMutableDictionary()
    ///保存collectionView中各cell的图片
    var dictCollectionViewImage = NSMutableDictionary()
    ///按照场景名称保存多个场景
    var dictScene = NSMutableDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView(tableView: tableView)

    }
    deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        initTable()
        
    }
    
    
    
    func initTable () {
        let ur1 = URL(string:"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1533616205291&di=5092fe449a9cdb54ac4686a5fd5d8478&imgtype=0&src=http%3A%2F%2Fpic2.ooopic.com%2F10%2F21%2F25%2F58b1OOOPICf2.jpg")
        
        let snapRecord1 = SnapRecord(ip: "192.168.88.81", url: ur6,ipState: "ON", rxSourceTxIP: "192.168.88.36", mac: "99")
        
        snaps.append(snapRecord1)

        self.tableView.reloadData()
        
    }

    
    func initTableView(tableView:UITableView) {
        //指定TableView的委托对象
        tableView.delegate = self
        tableView.dataSource = self
        
        //除去单元格分割线
        tableView.separatorStyle = .none
        //创建一个重用的单元格
        tableView.register(UINib(nibName: "CountTableViewCell", bundle: nil), forCellReuseIdentifier: "countCell")
        //去除尾部多余的空行
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        //设置分区头部字体颜色和大小
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
            .textColor = UIColor.gray
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
            .font = UIFont.boldSystemFont(ofSize: 16.0)
    }

    //执行图片下载任务
    func startDownloadForRecord(_ snapRecord: SnapRecord, indexPath: IndexPath, view: String){
        
        //判断队列中是否已有该图片任务
        if let _ = snapOperations.downloadsInProgress[indexPath] {
            return
        }
        //print(snapOperations.downloadQueue.operationCount)
        //创建一个下载任务
        let downloader = ImageDownloader(snapRecord: snapRecord)
        //任务完成后重新加载对应的单元格
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            DispatchQueue.main.async(execute: {

        self.snapOperations.downloadsInProgress.removeValue(forKey: indexPath)
                if view == "tableViewRX" {
                    self.tableViewRX.reloadData()

//                    self.tableViewRX.reloadRows(at: [indexPath], with: .fade)
                }else if view == "tableViewTX" {
                    self.tableViewTX.reloadData()
//                    self.tableViewTX.reloadRows(at: [indexPath], with: .fade)
                }
//                downloader.cancel()

            })
        }
        //记录当前下载任务
        snapOperations.downloadsInProgress[indexPath] = downloader
        //将任务添加到队列中
        snapOperations.downloadQueue.addOperation(downloader)
    }
    
    
    
    //执行图片滤镜任务
    func startFiltrationForRecord(_ snapRecord: SnapRecord, indexPath: IndexPath){
        if let _ = snapOperations.filtrationsInProgress[indexPath]{
            return
        }
        
        let filterer = ImageFiltration(snapRecord: snapRecord)
        filterer.completionBlock = {
            if filterer.isCancelled {
                return
            }
            DispatchQueue.main.async(execute: {
                self.snapOperations.filtrationsInProgress.removeValue(forKey: indexPath)
                self.tableViewRX.reloadRows(at: [indexPath], with: .fade)
            })
        }
        snapOperations.filtrationsInProgress[indexPath] = filterer
        snapOperations.filtrationQueue.addOperation(filterer)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

