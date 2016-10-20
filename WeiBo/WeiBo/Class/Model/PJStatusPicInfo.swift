//
//  PJStatusPicInfo.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/15.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit

class PJStatusPicInfo: NSObject {
    //转发图片地址
    var thumbnail_pic:String?
    
    init(dic :[String :AnyObject]){
        super.init()
        
        setValuesForKeysWithDictionary(dic)
        
}
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    
    }
}
