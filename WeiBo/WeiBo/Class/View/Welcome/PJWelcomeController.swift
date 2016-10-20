//
//  PJWelcomeController.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/12.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit

class PJWelcomeController: UIViewController {
//懒加载背景图片
  private lazy var bjImageView :UIImageView = {
        
        let img = UIImageView()
        img.image = UIImage(named: "ad_background")
        
        return img
        
    }()
    
//懒加载用户头像
    private lazy var userImageView :UIImageView = {
        
        let userimg = UIImageView()
        //设置圆角
        userimg.layer.cornerRadius = 42.5
        userimg.layer.masksToBounds = true
        //设置边线
        userimg.layer.borderWidth = 2
        userimg.layer.borderColor = UIColor.lightGrayColor().CGColor
        userimg.image = UIImage(named :"avatar_default_big")
        if let url  = PJUserAccountViewModel.shareUserAccount.userAccount?.avatar_large {
            
            userimg.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named :"avatar_default_big"))
        }
        return userimg
        
    }()
//懒加载欢迎标签
    private lazy var message :UILabel = {
        
        let text = UILabel()
        if let name = PJUserAccountViewModel.shareUserAccount.userAccount?.name{
            text.text = "欢迎归来\(name)"
        }else{
            text.text = "欢迎归来"
        }
        
        text.textColor = UIColor.darkGrayColor()
        text.sizeToFit()
        text.alpha = 0
        return text
    }()
    
    override func loadView() {
        view = bjImageView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
//搭建界面
    private func setUI(){
    
        view.backgroundColor = UIColor.whiteColor()
        //添加子控件
        view.addSubview(userImageView)
        view.addSubview(message)
        //添加头像约束
        userImageView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(200)
            make.centerX.equalTo(view.snp_centerX)
            make.size.equalTo(CGSize(width: 85, height: 85))
        }
        message.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(userImageView.snp_bottom)
            make.centerX.equalTo(userImageView.snp_centerX)
        }
        
    }
//界面动画
   override func viewDidAppear(animated:Bool){
          super.viewDidAppear(animated)
        startAnimation()
        }//开启动画
    private func startAnimation(){
    
        userImageView.snp_updateConstraints { (make) -> Void in
            make.top.equalTo(view).offset(400)
        }
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            self.view.setNeedsLayout()
            }) { (_ ) -> Void in
                UIView.animateWithDuration(1.0, animations: { () -> Void in
                    self.message.alpha = 1.0
                    }, completion: { (_) -> Void in
            //进入首页
         NSNotificationCenter.defaultCenter().postNotificationName(SwitchRootVCNotification, object: nil)
                        
                        
                })
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    

}
