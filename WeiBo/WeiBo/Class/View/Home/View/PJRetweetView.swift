//
//  PJRetweetView.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/13.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
import SnapKit

class PJRetweetView: UIView {

    var bottomConstraint :Constraint?
    
    
    var statusViewModel :PJStatusViewModel?{
        didSet{
            
            bottomConstraint?.uninstall()
            //设置转发内容
            contentLabel.text = statusViewModel?.retweetContent
            //有配图
            if let count = statusViewModel?.status?.retweeted_status?.pic_urls?.count where count > 0 {


                
                //设置模型
                picView.picInfo = statusViewModel?.status?.retweeted_status?.pic_urls
                
             
                
                // 更新约束
                
                self.snp_updateConstraints(closure: { (make) -> Void in
                    //  记录更新的约束
                    self.bottomConstraint = make.bottom.equalTo(picView.snp_bottom).offset(HomeCellMargin).constraint
                })
                

             
                
                picView.hidden = false
            }else{
                
                //没有配图
                
                self.snp_updateConstraints(closure: { (make) -> Void in
                    self.bottomConstraint = make.bottom.equalTo(contentLabel.snp_bottom).offset(HomeCellMargin).constraint
                })
            }

            
      
        }
    }
    
    //  添加视图设置约束
    private func setupUI() {
        //  添加控件
        addSubview(contentLabel)

        addSubview(picView)
        contentLabel.backgroundColor = UIColor(white: 0.95, alpha: 1)
        //  设置约束
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(HomeCellMargin)
            make.leading.equalTo(self).offset(HomeCellMargin)
            make.trailing.equalTo(self).offset(-HomeCellMargin)
            
        }
        picView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentLabel.snp_bottom).offset(HomeCellMargin)
            make.leading.equalTo(contentLabel)

        }
        
        //  关键的约束
        //  转发微博视图的底部约束等于我们转发内容label的底部约束加上一个间距
        self.snp_makeConstraints { (make) -> Void in
           self.bottomConstraint =  make.bottom.equalTo(picView.snp_bottom).offset(HomeCellMargin).constraint
        }
        
        
    }
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //懒加载转发内容
    private lazy var contentLabel :UILabel = {
        let label = UILabel (textColor: UIColor.grayColor(), fontSize: 14)
        label.numberOfLines = 0
         return label
    
    }()
    //懒加载转发图片
    private lazy var picView :PJPictureView = {
        
        let picView = PJPictureView()
        
        picView.backgroundColor = self.backgroundColor
        return picView
    }()
    

    
    
}
