//
//  PJMainController.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/9.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
import SVProgressHUD
class PJMainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tab = PJTabBar()
        
        // 设置代理对象
        
        tab.delegate = self
        
        tab.block = {[weak self] in
            

            //判断是否登录
                    if !PJUserAccountViewModel.shareUserAccount.isLogin {
                        SVProgressHUD.showErrorWithStatus("请先登录")
                        return
                    }
            
            
                  if let weakSelf = self {
                    
                        let composeView :PJComposeView = PJComposeView()
                        composeView.show(weakSelf)

            }
            
            
        }
        
        
        
      setValue(tab, forKey: "tabBar")
        
        
        
    //添加首页控制器
        addChildViewController(PJTHomeController(), title: "首页", imageName: "tabbar_home")
    //添加消息控制器
        addChildViewController(PJMessageController(), title: "消息", imageName: "tabbar_message_center")
    //添加发现控制器
        addChildViewController(PJDiscoveryController(), title: "发现", imageName: "tabbar_discover")
    //添加我控制器
        addChildViewController(PJProfileController(), title: "我的", imageName: "tabbar_profile")
        
        
        
        
        

    }
    
    

    func addChildViewController(childController: UIViewController, title:String, imageName:String) {
        //添加头部和底部标题
        childController.title = title
        //添加底部图片
        childController.tabBarItem.image = UIImage(named: imageName)
        //添加选中图片
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        //设置文字渲染
        childController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orangeColor()], forState: .Selected)
        //创建navigationController 将childContoller添加到navigationContoller
        let navi = UINavigationController(rootViewController: childController)
        //将navi添加到tarbarContoller
        addChildViewController(navi)
        
            
    }

    
    
}


// MARK:  - 实现代理方法

extension PJMainController : PJTabBarDelegate {
    
    func didSelectComposeButton() {
        print("sss")
    }
   // func didSelectComposeButton() {
        

    
        //判断是否登录
//        if !PJUserAccountViewModel.shareUserAccount.isLogin {
//            SVProgressHUD.showErrorWithStatus("请先登录")
//            return
//        }
//
//        let composeView :PJComposeView = PJComposeView()
//        
//        view = composeView
//        
//        
//        
//        
//        
//        
//        
//        
//        
//    }
    
}
