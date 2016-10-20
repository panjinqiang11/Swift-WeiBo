//
//  PJTabBar.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/9.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
protocol PJTabBarDelegate :NSObjectProtocol {
    
    func didSelectComposeButton()
    
    
}


class PJTabBar: UITabBar {

    
    var block :(() -> ())?
    //定义代理对象
    weak var pjdelegate:PJTabBarDelegate?
    
    private lazy var composeButton :UIButton = {
        
      let button = UIButton()
        //设置图片和高亮图片
        button.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        
        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        //设置背景图片
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        button.sizeToFit()
        
        button.addTarget(self, action: "clikButton", forControlEvents: .TouchUpInside)
        return button
}()
    
     // MARK:  - 点击按钮实现代理方法
   @objc private func clikButton() {
    

        
        pjdelegate?.didSelectComposeButton()
    
    
       block?()
        
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //添加button
    private func setUI(){
        addSubview(composeButton)
        
    }
   
    
    //  调整子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews()
        //  设置按钮的中心点
        composeButton.centerX = width * 0.5
        composeButton.centerY = height * 0.5
        
        //  设置按钮的宽度
        let itemWidth = width / 5
        //  记录遍历到第几个系统的按钮
        var index = 0
        
       
        
        //  调整系统控件的位置及大小
        for value in subviews {
            //UITabBarButton 系统私有的类，不能直接使用
            if value.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                
                value.width = itemWidth
                value.x = CGFloat(index) * itemWidth
                index++
                //  将要显示搜索按钮的时候多加一个宽度，隔过去中间的加号按钮
                if index == 2 {
                    index++
                }
                
                
            }
        }
        
        
        
        
    }
    

   
}
