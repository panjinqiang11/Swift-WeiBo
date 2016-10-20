//
//  PJComposeButton.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/18.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
//自定义composeView的 button
class PJComposeButton: UIButton {
   
     var composeMenu :PJComposeButtonList?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
        
    titleLabel?.font = UIFont.systemFontOfSize(15)
        setTitleColor(UIColor.grayColor(), forState: .Normal)
        titleLabel?.textAlignment = .Center
            }
    
    //  重写highlighted属性
    override var highlighted: Bool {
        get {
            return false
        }
        set {
            
        }
    }

    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        imageView?.x = 0
        
        imageView?.y = 0

        imageView?.width = width
        
        imageView?.height = width
        
        
        titleLabel?.x = 0
        titleLabel?.y = width
        titleLabel?.width = width
        titleLabel?.height = height - width
        
        
    }
    
}
