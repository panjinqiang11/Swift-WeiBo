//
//  PJToolBarView.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/13.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit

class PJToolBarView: UIView {

  //懒加载控件
    private lazy var retweetButton: UIButton = self.addButton("timeline_icon_retweet", title: "转发")
    private lazy var commentButton: UIButton = self.addButton("timeline_icon_comment", title: "评论")
    private lazy var unlikeButton: UIButton = self.addButton("timeline_icon_unlike", title: "赞")
    

  

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
var statusViewModel :PJStatusViewModel?{

    didSet{
        
        retweetButton.setTitle(statusViewModel?.retweetStr, forState: .Normal)
        commentButton.setTitle(statusViewModel?.commentStr, forState: .Normal)
        unlikeButton.setTitle(statusViewModel?.unlikeStr, forState: .Normal)
    }
}
    
    //  按钮中间的竖线
    private func addChildLine() -> UIImageView {
        
        let imageView = UIImageView(image: UIImage(named: "timeline_card_bottom_line"))
        
        //  添加控件
        addSubview(imageView)
        
        return imageView
        
        
    }

//创建button公用方法

private func addButton(imageName:String ,title:String) -> UIButton{
    
     let button = UIButton ()
    button.setImage(UIImage(named: imageName), forState: .Normal)
    button.setBackgroundImage(UIImage(named: "timeline_card_bottom_background"), forState: .Normal)
    //取消高亮
     button.adjustsImageWhenHighlighted = false
    button.setTitle(title, forState: .Normal)
    //  指定文字大小
    button.titleLabel?.font = UIFont.systemFontOfSize(15)
    //  指定文字颜色
    button.setTitleColor(UIColor.grayColor(), forState: .Normal)


    addSubview(button)


    return button

}
    
    //  添加控件设置约束
    private func setupUI() {
        
       
        
        //  设置按钮相应的约束
        retweetButton.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(commentButton)
        }
        commentButton.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(retweetButton.snp_trailing)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(unlikeButton)
        }
        
        unlikeButton.snp_makeConstraints { (make) -> Void in
            make.trailing.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.leading.equalTo(commentButton.snp_trailing)
        }
        
        
        //  添加线
        let firstLine = addChildLine()
        let secondLine = addChildLine()
        //  设置图片约束
        firstLine.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(retweetButton.snp_trailing)
            make.centerY.equalTo(self.snp_centerY)
        }
        secondLine.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(commentButton.snp_trailing)
            make.centerY.equalTo(self.snp_centerY)
        }
        
        
        
        
    }


}