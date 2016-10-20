//
//  PJUserAccountViewModel.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/12.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit

class PJUserAccountViewModel: NSObject {

    //创建单例
    static let shareUserAccount :PJUserAccountViewModel = PJUserAccountViewModel()
    
    var userAccount:PJUserAount? {
        
        return PJUserAount.loadUserAccount()
    }
   //私有化
   private override init(){
        
        super.init()
    }
    //判断accessToken是否为nil
    
    var isLogin :Bool{
        

        

        
        return accessToken != nil
    }
    
    var accessToken: String? {
        
        guard let token = userAccount?.access_token else{
            
            return nil
        }
        let result = userAccount?.expiresDate?.compare(NSDate())
        if result == NSComparisonResult.OrderedDescending {
            
            return token
        }else{
            return nil
        }
        

        
    }
    
    
    //通过授权码获得accesstoken
     func requestAccesstoken(code: String ,callBack: (isSuccess :Bool) -> ()) {
        
        //调用PJNetworkTools中的requestAccessToken方法
        
        PJNetworkTools.shareTools.requestAccessToken(code) { (response, error) -> () in
            if error != nil{
                callBack(isSuccess: false)
                return//请求失败
            }else {
                //回调数据
                guard let dic = response as? [String :AnyObject] else{
                    
                    print("不是正确json格式")
                    return
                }
                
                //通过令牌获得用户信息
                let user = PJUserAount(dic: dic)

                self.requestUserInfo(user,callBack: callBack)
                
                
                
            }
            
        }
    }
    
    // MARK:  - 请求用户信息
    
    private func requestUserInfo(userAccount: PJUserAount,callBack: (isSuccess :Bool) -> ()){
        
        PJNetworkTools.shareTools.requestUserInfo(userAccount) { (response, error) -> () in
            if error != nil {
                
               callBack(isSuccess: false)
                return
            }
            
            guard let dic = response as? [String :AnyObject] else{
                
                callBack(isSuccess: false)
                
                return
            }
            let name = dic["name"]
            let avatar_large = dic["avatar_large"]
            
            //  设置用户名和头像
            userAccount.name = name as? String
            userAccount.avatar_large = avatar_large as? String
            
            print(avatar_large)
            //  保存用户对象
          let result = userAccount.saveUserAccount()
            
            if result {
                
                callBack(isSuccess: true)
            }else {
                callBack(isSuccess: false)
            }
            
        }
        
        
    }


}
