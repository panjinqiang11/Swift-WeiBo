//
//  PJComposeTextView.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/20.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit

class PJComposeTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
       
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //懒加载placeHolderLabel
    private lazy var placeHolderLabel :UILabel = {
        
        let label = UILabel()
        label.text = "请输入文字"
        label.font = UIFont.systemFontOfSize(15)
        label.textColor = UIColor.grayColor()
        return label
    }()
    
    
   override var text :String? {
        
        didSet{
            
            placeHolderLabel.hidden = hasText()
            
        }
    }
    private func setUI() {
     
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textChange", name:UITextViewTextDidChangeNotification , object: nil)
      
        addSubview(placeHolderLabel)
        
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: placeHolderLabel, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: placeHolderLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: placeHolderLabel, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1, constant: -10))
        
        
    }
    
    //监听方法
  @objc private func textChange(){
        
        placeHolderLabel.hidden = self.hasText()
        
    }
    
    }
