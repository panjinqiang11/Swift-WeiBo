//
//  PJStatusListViewModel.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/13.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
//对应首页tableview
class PJStatusListViewModel: NSObject {

    lazy var statusList :[PJStatusViewModel] = [PJStatusViewModel]()
    
    //  加载微博数据
    func loadStatus(isUp:Bool, callBack: (isSuccess:Bool) -> ()) {
        
        var maxId: Int64 = 0
        var sinceId: Int64 = 0
        
        if isUp {   //如果是上拉加载更多
        //获得最后一条微博的id
        maxId = statusList.last?.status?.id ?? 0
        //防止重复加载
            if maxId > 0 {
                maxId -= 1
            }
            
        }else {    //如果是下拉刷新
            
            sinceId = statusList.first?.status?.id ?? 0
        }
        
        PJNetworkTools.shareTools.loadStatus(maxId, sinceId: sinceId) { (response, error) -> () in
       
            if error != nil {
                print(error)
                return
            }
            //  代码执行到此,是成功的回调
            
            guard let dic = response as? [String: AnyObject] else {
                print("不是一个正确的字典格式")
                return
            }
            
            //  代码执行到此字典格式正确
            
            guard let statusDicArray = dic["statuses"] as? [[String: AnyObject]] else {
                print("不是一个正确的字典格式")
                return
            }
            
            //  遍历数组完成字典转模型
            var tempArray = [PJStatusViewModel]()
            for statusDic in statusDicArray {
                
                let status = PJStatus(dic: statusDic)
                let statusViewModel = PJStatusViewModel(status: status)
                
                tempArray.append(statusViewModel)
            }
            //  设置数据
//            self.statusList = tempArray
            if isUp {
                
                self.statusList.appendContentsOf(tempArray)
            }else {
                
                self.statusList.insertContentsOf(tempArray, at: 0)
               // self.statusList += tempArray
            }
            //闭包回调刷新数据
            
            callBack(isSuccess: true)
            

            
            
        }
    }

}
