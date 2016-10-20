//
//  PJVistorController.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/9.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit

class PJVistorController: UITableViewController {

    var isLogin: Bool =  PJUserAccountViewModel.shareUserAccount.isLogin
    
    var vistorView :PJVistorView?
    
    
    
    override func loadView() {
        if isLogin{    //登录
            
            super.loadView()
        }else{
            
                      //未登录
            setUI()
            
            vistorView = PJVistorView()
            
            vistorView?.closure = {[weak self] in
                self?.showOAuth()
            }
            
            view = vistorView

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
           }

     private func setUI() {
        //添加左侧注册按钮
         navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", target: self, action: "register")
        //添加右侧注册按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", target: self, action: "login")
    }
    
     // MARK:  - 点击左侧注册按钮
    @objc private func register(){
        
        showOAuth()
    }
    
     // MARK:  - 点击右侧登录按钮
    
    @objc private func login(){
        
        showOAuth()
        
    }
     // MARK:  - 跳转登录注册页面
    private func showOAuth(){
        
        let oautController = PJOAuthController()
        
        let na = UINavigationController(rootViewController: oautController)
        
        
        
        presentViewController(na, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}
