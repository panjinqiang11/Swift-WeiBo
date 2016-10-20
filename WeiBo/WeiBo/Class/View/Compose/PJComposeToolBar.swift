//
//  PJComposeToolBar.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/19.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
enum composeToolBarButtonType :Int{
    
    case Picture = 0
    case Mention = 1
    case Trend = 2
    case Emotion = 3
    case Add = 4
    
}


class PJComposeToolBar: UIStackView {
    
    var emotoinButton :UIButton?

    var selectClosure :((type: composeToolBarButtonType) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupUI() {
        //设置布局
        axis = .Horizontal
        distribution = .FillEqually
        
        backgroundColor = UIColor.redColor()
        
        addButton("compose_toolbar_picture", type: .Picture)
        addButton("compose_mentionbutton_background", type: .Mention)
        addButton("compose_trendbutton_background", type: .Trend)
       emotoinButton = addButton("compose_emoticonbutton_background", type: .Emotion)
        addButton("compose_add_background", type: .Add)
        
      
        
        
    }
    
    private func addButton(imageName: String,type: composeToolBarButtonType) -> UIButton{
        
       let button = UIButton()
        button.tag = type.rawValue
        
        button.addTarget(self, action: "clickButton:", forControlEvents: .TouchUpInside)
        //  设置图片
        button.setImage(UIImage(named: imageName), forState: .Normal)
        button.setImage(UIImage(named: "\(imageName)_highlighted"), forState: .Highlighted)
        //  设置背景图片
        button.setBackgroundImage(UIImage(named: "compose_toolbar_background"), forState: .Normal)
        button.adjustsImageWhenHighlighted = false
        
        
       // addSubview(button)
        addArrangedSubview(button)
        
        return button
        

    }
    @objc private func clickButton(button: UIButton){
        
        let type = composeToolBarButtonType(rawValue: button.tag)!
        
        selectClosure?(type: type)
           }
    
    func showEnmotion(isEmotion: Bool){
        
        if isEmotion {
            
            emotoinButton?.setImage(UIImage(named: "compose_keyboardbutton_background"), forState: .Normal)
            emotoinButton?.setImage(UIImage(named: "compose_keyboardbutton_background_highlighted"), forState: .Highlighted)
        } else {
            emotoinButton?.setImage(UIImage(named: "compose_emoticonbutton_background"), forState: .Normal)
            emotoinButton?.setImage(UIImage(named: "compose_emoticonbutton_background_highlighted"), forState: .Highlighted)
        }

            
            
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

