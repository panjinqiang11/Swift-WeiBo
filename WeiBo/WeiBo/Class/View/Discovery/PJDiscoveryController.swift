//
//  PJDiscoveryController.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/9.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit

class PJDiscoveryController: PJVistorController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if isLogin  {
        
      
        }else{
            
            vistorView?.updateVisitorInfo("登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过", imageName: "visitordiscover_image_message")
            
            
        }
        
          setupUI()

    }
    
    
    private func setupUI() {
     
        let searchView = PJDiscoverSearchView.searchView()
        
        searchView.width = self.view.width
        
        navigationItem.titleView = searchView
        
        
        
        tabBarItem.badgeValue = "哈哈"
    }
    

 
}
