//
//  PJStatusOriginalView.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/13.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit
//原创微博
class PJStatusOriginalView: UIView {
   
    var bottomConstraint :Constraint?
    var statusViewModel :PJStatusViewModel?{
        didSet{
            
            headerImageView.sd_setImageWithURL(NSURL(string: (statusViewModel?.status?.user!.profile_image_url)!), placeholderImage: UIImage(named: "avatar_default_big"))
            
            screenNameLabel.text = statusViewModel?.status?.user!.screen_name
            
            timeLabel.text = "刚刚"
            sourceLabel.text = statusViewModel?.sourceContent
            
            verifiedTypeImageView.image = statusViewModel?.verifiedtypeImage
            
            contentLabel.text = statusViewModel?.status?.text
            
            mbrankImageView.image = statusViewModel?.mbrankImage
            
            
           bottomConstraint?.uninstall()
            //有配图
            if let count = statusViewModel?.status?.pic_urls?.count where count > 0 {
            
               picView.hidden = false
                
                //设置模型
                picView.picInfo = statusViewModel?.status?.pic_urls
                 //更新约束
                
                self.snp_updateConstraints(closure: { (make) -> Void in
                     // 记录更新的约束
                    self.bottomConstraint = make.bottom.equalTo(picView.snp_bottom).offset(HomeCellMargin).constraint
                })
            }else{
                
                //没有配图
                picView.hidden = true
            
                self.snp_updateConstraints(closure: { (make) -> Void in
                    self.bottomConstraint = make.bottom.equalTo(contentLabel.snp_bottom).offset(HomeCellMargin).constraint
                })
            }

        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK:  - 懒加载控件
    //头像
    private lazy var headerImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    //认证等级
    private lazy var verifiedTypeImageView :UIImageView = UIImageView(image: UIImage(named: "avatar_vip"))
    //昵称
    private lazy var screenNameLabel :UILabel = UILabel.init(textColor: UIColor.orangeColor(), fontSize: 12)
    //会员等级
    private lazy var mbrankImageView: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
    //时间
    private lazy var timeLabel :UILabel = UILabel.init(textColor: UIColor.orangeColor(), fontSize: 12)
    // 来源
    private lazy var sourceLabel :UILabel = UILabel.init(textColor: UIColor.lightGrayColor(), fontSize: 12)
    //微博内容
    private lazy var contentLabel :UILabel = {
        let content = UILabel.init(textColor: UIColor.darkGrayColor(), fontSize: 15)
        content.numberOfLines = 0
        return content
}()
    //图片
    private lazy var picView :PJPictureView = {
        let pic = PJPictureView()
        
        pic.backgroundColor = self.backgroundColor
        return pic
    }()
    
    
    
      
    private func setupUI(){
        
        self.backgroundColor = UIColor.whiteColor() 
        
        addSubview(headerImageView)
        addSubview(verifiedTypeImageView)
        addSubview(screenNameLabel)
        addSubview(mbrankImageView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        addSubview(contentLabel)
        addSubview(picView)
        
        
        
        headerImageView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(HomeCellMargin)
            make.leading.equalTo(self).offset(HomeCellMargin)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        verifiedTypeImageView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(headerImageView.snp_trailing)
            make.centerY.equalTo(headerImageView.snp_bottom)
        }
        screenNameLabel.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(headerImageView.snp_trailing).offset(HomeCellMargin)
            make.top.equalTo(headerImageView)
        }
        mbrankImageView.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(screenNameLabel.snp_trailing).offset(HomeCellMargin)
            make.top.equalTo(screenNameLabel)
        }
        timeLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(headerImageView)
            make.leading.equalTo(headerImageView.snp_trailing).offset(HomeCellMargin)
        }
        sourceLabel.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(timeLabel.snp_trailing).offset(HomeCellMargin)
            make.bottom.equalTo(timeLabel)
        }
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(headerImageView.snp_bottom).offset(HomeCellMargin)
            make.leading.equalTo(headerImageView)
            make.trailing.equalTo(self).offset(-HomeCellMargin)
            
        }
        
        
        
        picView.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(contentLabel)
            make.top.equalTo(contentLabel.snp_bottom).offset(HomeCellMargin)
            

        }
        
        
        
        self.snp_makeConstraints { (make) -> Void in
            
            self.bottomConstraint = make.bottom.equalTo(picView).offset(HomeCellMargin).constraint
            
            
        }
        
            }
    
}
