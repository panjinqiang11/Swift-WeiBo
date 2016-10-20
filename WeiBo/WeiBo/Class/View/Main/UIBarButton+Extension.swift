//
//  UIBarButton+Extension.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/9.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    //定义便利构造函数
    convenience init(title: String, target: AnyObject?, action: Selector) {
    //调用指定构造函数
    self.init()
        
        let button :UIButton = UIButton()
        //设置标题
        button.setTitle(title, forState: .Normal)
        //设置标题颜色
        button.setTitleColor(UIColor.grayColor(), forState: .Normal)
        button.setTitleColor(UIColor.orangeColor(), forState: .Selected)
        //设置尺寸
        button.sizeToFit()
        //设置title大小
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        // 添加点击事件
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        //自定义button
        customView = button
        
    }
    
    
    
    
    
}
