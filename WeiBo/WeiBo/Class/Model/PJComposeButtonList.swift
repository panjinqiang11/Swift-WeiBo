//
//  PJComposeButtonList.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/18.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit

class PJComposeButtonList: NSObject {

    var className :String?
    var icon :String?
    var title: String?
    
    init(dic :[String :NSObject]) {
        super.init()
        setValuesForKeysWithDictionary(dic)
    }
    
    
    
}
