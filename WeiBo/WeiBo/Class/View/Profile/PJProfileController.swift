//
//  PJProfileController.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/9.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit

class PJProfileController: PJVistorController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
         vistorView?.updateVisitorInfo("登录后，你的微博、相册、个人资料会显示在这里，展示给别人", imageName: "visitordiscover_image_profile")
        
    }

  
}
