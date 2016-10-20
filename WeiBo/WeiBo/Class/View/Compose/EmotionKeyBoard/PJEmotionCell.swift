//
//  PJEmotionCell.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/21.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit

class PJEmotionCell: UICollectionViewCell {

    //懒加载button数组
   private lazy var emotionButton: [PJEmotionButton] = [PJEmotionButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addbutton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //懒加载模型 , 设置button的图片
    var emotions :[PJEmotion]? {
    
        didSet{
            guard let etc = emotions else{
                return
            }
             for (i , value) in etc.enumerate() {
                
                let button = emotionButton[i]
                
                
                button.emotion = value
                
                //图片
                if value.type! == "0" {
                    
                    button.setImage(UIImage(named: value.path!), forState: .Normal)
                    button.setTitle(nil, forState: .Normal)
                }else{
                //emotion
                    button.setTitle((value.code! as NSString).emoji(), forState: .Normal)
                    
                    button.setImage(nil, forState: .Normal)
                }
                
                
            }
            
            
        }
        
        
    }
    
    
    
    
    //添加button控件
    private func addbutton(){
        
        for _ in 0..<20{
            
         let button = PJEmotionButton()
            
          

            button.addTarget(self , action: "clickKeyBoardButton:", forControlEvents: .TouchUpInside)

            button.titleLabel?.font = UIFont.systemFontOfSize(34)
            contentView.addSubview(button)
            emotionButton.append(button)
        }
    }
    //设置布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonW = width / 7
        let buttonH = height / 3
        
        for (i, value) in emotionButton.enumerate(){
        
            let row = i / 7
            let col = i % 7
            let buttonX = buttonW *  CGFloat(col)
            let buttonY = buttonH * CGFloat(row)
            
            value.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH)
            
        }
        
    }
    
  @objc  private func clickKeyBoardButton(button: PJEmotionButton){
        
        let emotion = button.emotion!
            //发送点击键盘按钮通知
        NSNotificationCenter.defaultCenter().postNotificationName("clickKeyBoardButtonNotification", object: emotion)
    }
    
    
}
