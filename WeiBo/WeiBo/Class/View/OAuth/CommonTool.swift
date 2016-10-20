//
//  CommonTool.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/12.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit

//  切换根视图控制器通知名
let SwitchRootVCNotification = "SwitchRootVCNotification"
let ScreenWidth = UIScreen.mainScreen().bounds.size.width
let SreenHeight = UIScreen.mainScreen().bounds.size.height

//随机生成颜色

func RGB(red: CGFloat,green: CGFloat, blue :CGFloat) -> UIColor{
    
    
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}
func RandomColor() -> UIColor{
    
    let red = random() % 256
    let green = random() % 256
    let blue = random() % 256
    
    return RGB(CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255)
    
}