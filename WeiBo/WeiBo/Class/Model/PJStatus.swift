//
//  PJStatus.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/12.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
//微博模型
class PJStatus: NSObject {
    //创建时间
    var created_at: String?
    //微博id
    var id: Int64 = 0
    //微博信息内容
    var text: String?
    //微博来源
    var source: String?
    var user: PJUser?
    //  转发数
    var reposts_count: Int = 0
    //  评论数
    var comments_count: Int = 0
    //  表态数(赞)
    var attitudes_count: Int = 0
    // 转发微博
    var retweeted_status: PJStatus?
    //配图信息
    var pic_urls: [PJStatusPicInfo]?
    init(dic:[String: AnyObject]){
        
        super.init()
        setValuesForKeysWithDictionary(dic)
    }
    //防止崩溃
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
     // MARK:  - 修改字典转模型
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "user" {
            //如果key值为user 单独字典转模型
            user = PJUser(dic: value as! [String :AnyObject])

            
        }else if key == "retweeted_status"{
            
            retweeted_status = PJStatus(dic: value as! [String :AnyObject])
            
        }else if key == "pic_urls" {
            
            guard let dicArr = value as? [[String:AnyObject]] else {
                
                return
            }
            var temperArr = [PJStatusPicInfo]()
            for dic in dicArr {
                
                let picInfo = PJStatusPicInfo(dic: dic)
                
                temperArr.append(picInfo)
                
                
            }
            pic_urls = temperArr
            

            
            
            
        }else {
        super.setValue(value, forKey: key)
        }
    }
}
