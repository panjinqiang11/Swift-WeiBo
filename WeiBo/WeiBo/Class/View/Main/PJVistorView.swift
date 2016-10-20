//
//  PJVistorView.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/9.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
import SnapKit

class PJVistorView: UIView {
    var closure :(() -> ())?
//遮罩图片
    private lazy var coverImageView :UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
//懒加载循环图片
  private lazy var cycleImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
//懒加载房屋图片
    private lazy var houseImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
//懒加载按钮  登录
    private lazy var registerButton :UIButton = {
        let button = UIButton()
        button.addTarget(self, action: "login", forControlEvents: .TouchUpInside)

        button.setTitle("注册", forState: .Normal)
        button.setTitleColor(UIColor.grayColor(), forState: .Normal)
        button.setTitleColor(UIColor.orangeColor(), forState: .Selected)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
         button.titleLabel?.font = UIFont.systemFontOfSize(15)
        return button
        
    }()
    
//登录
    private lazy var loginButton :UIButton = {
        
        let button = UIButton()
        button.addTarget(self, action: "login", forControlEvents: .TouchUpInside)

        button.setTitle("登录", forState: .Normal)
        button.setTitleColor(UIColor.grayColor(), forState: .Normal)
        button.setTitleColor(UIColor.orangeColor(), forState: .Selected)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        
        return button
        
    }()
    
    //点击登陆注册

    @objc private func login() {
        closure?()
    }
    
//懒加载label
    private lazy var label :UILabel = {
        
        let text :UILabel = UILabel()
        
        text.textAlignment = .Center
        
        text.numberOfLines = 0
        
        text.text = "关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜"
        
        text.textColor = UIColor.grayColor()
        
        text.font = UIFont.systemFontOfSize(14)
        
        return text
        
    }()
        
        
    
        
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        
       
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 // MARK:  - 设置控件并添加
    private func setUI() {
        
    backgroundColor = UIColor(white: 237 / 255, alpha: 1)
    addSubview(cycleImageView)
    addSubview(houseImageView)
    addSubview(label)
    addSubview(loginButton)
    addSubview(registerButton)
    addSubview(coverImageView)

   cycleImageView.snp_makeConstraints { (make) -> Void in
    make.center.equalTo(self)
        }
    houseImageView.snp_makeConstraints { (make) -> Void in
        make.center.equalTo(cycleImageView)
        }
    coverImageView.snp_makeConstraints { (make) -> Void in
        make.center.equalTo(cycleImageView)
        }
        
    label.snp_makeConstraints { (make) -> Void in
        make.centerX.equalTo(cycleImageView)
        make.width.equalTo(224)
        make.top.equalTo(cycleImageView.snp_bottom)
        }
        
    loginButton.snp_makeConstraints { (make) -> Void in
        make.leading.equalTo(label)
        make.top.equalTo(label.snp_bottom).offset(10)
        make.size.equalTo(CGSizeMake(100 ,35))
        }
        
    registerButton.snp_makeConstraints { (make) -> Void in
        make.size.equalTo(loginButton)
        make.top.equalTo(loginButton)
        make.trailing.equalTo(label)
        }
        
        
    }
    
 // MARK:  - 开启旋转动画
    
    private func animation() {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.duration = 20
        
        animation.repeatCount = MAXFLOAT
        
        animation.toValue = 2 * M_PI
        
        
        animation.removedOnCompletion = false
        
        
        cycleImageView.layer.addAnimation(animation, forKey: nil)
        
    }
    
    
//  修改visitor视图
    
      func updateVisitorInfo(message: String?, imageName: String?){
        
        if let msg = message,img = imageName{
            
            label.text = msg
            houseImageView.image = UIImage(named: img)
            
            cycleImageView.hidden = true
        }else{
            
            cycleImageView.hidden = false
            
            animation()
            
        }
    }
    
    
    
    
    
    
}
