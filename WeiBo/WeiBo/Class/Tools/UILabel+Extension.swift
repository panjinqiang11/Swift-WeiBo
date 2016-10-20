//
//  UILabel+Extension.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/13.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
extension UILabel{
    
    convenience init(textColor: UIColor , fontSize :CGFloat){
        
        self.init()
        self.textColor = textColor
        self.font = UIFont.systemFontOfSize(fontSize)
    }
}

