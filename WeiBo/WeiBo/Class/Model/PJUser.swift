//
//  PJUser.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/13.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
//用户模型
class PJUser: NSObject {
    //  用户昵称
    var screen_name: String?
    //  用户头像地址
    var profile_image_url: String?
    //  认证类型等级 认证类型 -1 没有认证 ，0 认证用户，2，3，5 企业认证 ， 220 达人
    var verified_type: Int = 0
    //  会员等级 1-6
    var mbrank: Int = 0
    
  // MARK:  - 构造函数
    init(dic: [String :AnyObject]){
        
        super.init()
        //字典转模型
        setValuesForKeysWithDictionary(dic)
    }
    //防止崩溃
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    
    
}
