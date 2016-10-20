//
//  UIImage+Extension.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/18.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit


extension UIImage {
    
    
    class func getScreenShot () -> UIImage {
        
        let window = UIApplication.sharedApplication().keyWindow!
        
        //开启上下文
        UIGraphicsBeginImageContext(window.size)
        //把window 内容渲染到上下文上
        window.drawViewHierarchyInRect(window.bounds, afterScreenUpdates: false)
        
        //从上下文中获取图片
        let img = UIGraphicsGetImageFromCurrentImageContext()
                
        //关闭上下文
        UIGraphicsEndImageContext()
        
        return img
        
    }
    
}



