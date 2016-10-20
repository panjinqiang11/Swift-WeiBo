//
//  PJEmotion.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/21.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit

class PJEmotion: NSObject {
    var chs :String?
    
    var code :String?
    var type: String?
    var png: String?
    //图片全路径
    var path :String?
    
    init(dic: [String:AnyObject]){
        
        super.init()
        setValuesForKeysWithDictionary(dic)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
