//
//  PJKeyBoardBar.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/21.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit

enum EmotionType :Int {
    
    case  Normal = 1000
    case Emoji = 1001
    case Lxh = 1002
}
class PJKeyBoardBar: UIStackView {

    
    //上次点击的button
    var lastSelectedButton :UIButton?
    var selectButton: ((type: EmotionType) -> Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        
        
        axis = .Horizontal
        distribution = .FillEqually
        addButton("默认", imageName: "compose_emotion_table_left",type: .Normal)
        addButton("Emoji", imageName: "compose_emotion_table_mid",type: .Emoji)
        addButton("浪小花", imageName: "compose_emotion_table_right",type: .Lxh)
        
    }
    
    private func addButton(title:String, imageName: String ,type:EmotionType) {
        
        let button = UIButton()
        button.tag = type.rawValue
        button.addTarget(self, action: "clikButtonAction:", forControlEvents: .TouchUpInside)
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.setTitleColor(UIColor.redColor(), forState: .Selected)
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        //  设置背景图片
        button.setBackgroundImage(UIImage(named: imageName + "_normal"), forState: .Normal)
        button.setBackgroundImage(UIImage(named: imageName + "_selected"), forState: .Selected)
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        //取消高亮
        button.adjustsImageWhenHighlighted = false
        addArrangedSubview(button)
        
        if type == .Normal {
            
            lastSelectedButton?.selected = false
            button.selected = true
            lastSelectedButton = button
        }
        
        
    }
    @objc private func clikButtonAction(button :UIButton){
        
        if button == lastSelectedButton {
            
            return
        }
       
        lastSelectedButton?.selected = false
        
        button.selected = true
        
        lastSelectedButton = button
        
        
        let type = EmotionType(rawValue: button.tag)!
        
        selectButton?(type: type)
        
        

    }
    
    func seleButton(section: Int){
        
        let button = viewWithTag(section + 1000) as! UIButton
        
        if lastSelectedButton == button{
            return
        }else {
            
            lastSelectedButton?.selected = false
            
            button.selected = true
            
            lastSelectedButton = button
            
         
            
            
        }
             }
    
    
    
}
