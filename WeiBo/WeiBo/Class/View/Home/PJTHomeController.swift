//
//  PJTHomeController.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/9.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
import SVProgressHUD
private let key = "PJTHomeController"
class PJTHomeController: PJVistorController {
    
 //懒加载菊花转视图
    
    private lazy var pullUpView :UIActivityIndicatorView = {
        
        let indtor = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        indtor.color = UIColor.redColor()
        
        return indtor
    }()
    
//使用系统的下拉刷新
//    private lazy var pullDownView :UIRefreshControl = {
//        let ctr = UIRefreshControl()
//        ctr.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
//        return ctr
//    }()
//    
 //使用自定义下拉刷新
    private lazy var pullDownView :PJRefreshController = {
        let ctr = PJRefreshController()
        ctr.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
        return ctr
    }()
    
    @objc func refresh(){
        

        loadStatus()
        
       // pullDownView.endRefreshing()

    }
    
    //结束下拉刷新
    private func endRefresh(){
        //上拉加载数据后结束动画
        pullUpView.stopAnimating()
        
        //下拉刷新加载数据后 结束下拉刷新
        pullDownView.endRefreshing()
    }
private lazy var statusListViewModel: PJStatusListViewModel = PJStatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isLogin  {
            setupTableView()
            loadStatus()
            
        }else{
            
            vistorView?.updateVisitorInfo(nil , imageName: "nil")
            
        }
        
    }
    
    private func loadStatus() {
        statusListViewModel.loadStatus(pullUpView.isAnimating()) { (isSuccess) -> () in
        
            self.endRefresh()

            if isSuccess {
                
                self.tableView.reloadData()
                
            }
         }
       
    }

    private func setupTableView() {
        
        //注册cell
        tableView.registerClass(PJHomeTableViewCell.self, forCellReuseIdentifier: key)
        //去掉分隔线
        tableView.separatorStyle = .None
        
        //  设置自动行高, 通过约束设置高度
        tableView.rowHeight = UITableViewAutomaticDimension
        //  预估行高
        tableView.estimatedRowHeight = 200

        
        //定义footView
        tableView.tableFooterView = pullUpView
        //添加下拉刷新
        tableView.addSubview(pullDownView)
        
        pullUpView.sizeToFit()
        
        
        
        
           }

        
   }
extension PJTHomeController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return statusListViewModel.statusList.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(key, forIndexPath: indexPath) as! PJHomeTableViewCell
        
        //设置cell没有选中颜色
        cell.selectionStyle = .None
        let statusViewModel = statusListViewModel.statusList[indexPath.row]
        
        cell.statusViewModel = statusViewModel
        
        
        return cell
        
            }
    
    //  将要显示那个cell
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //  判断是否是最后一个cell
        if indexPath.row == statusListViewModel.statusList.count - 1 && !pullUpView.isAnimating() {
      
            //  开启菊花转
            pullUpView.startAnimating()
            //  数据请求 上拉加载更多
            loadStatus()


        }
        
        
    }
    
    
}






