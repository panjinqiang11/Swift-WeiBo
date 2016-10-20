//
//  PJMessageController.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/9.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit

class PJMessageController: PJVistorController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if isLogin  {
            
            
        }else{
            
            
  
            
           vistorView?.updateVisitorInfo("登录后，别人评论你的微博，发给你的消息，都会在这里收到通知", imageName: "visitordiscover_image_message")
            
        }
        
    }
    

    

   
}
