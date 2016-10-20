//
//  PJComposeView.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/18.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
import pop
class PJComposeView: UIView {

   private lazy var composeButtonArr =  [PJComposeButton]()
    

    private var target :UIViewController?
    //懒加载数据
  private lazy  var infoArr:[PJComposeButtonList] = {
        
    let path = NSBundle.mainBundle().pathForResource("compose.plist", ofType: nil)
        
    let dicarr = NSArray(contentsOfFile: path!)
        
        
        var temparr  = [PJComposeButtonList]()
        
        for dic in dicarr! {
            
            let composeList = PJComposeButtonList(dic: dic as! [String : NSObject])
            
            temparr.append(composeList)
        }
        
        

        return temparr
        
        
    }()
    
 // MARK:  - 开启动画
   
    private func startAnimation(isUp:Bool,value: PJComposeButton,i :Int) {
        
     let animation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        
        let y = isUp ? value.y - 350 :value.y + 350
        animation.toValue = NSValue(CGPoint: CGPoint(x: value.centerX, y: y))

        animation.springSpeed = 10
        animation.beginTime  = CACurrentMediaTime() + Double(i) * 0.025
        animation.springBounciness = 8
        value.pop_addAnimation(animation, forKey: nil)
        
        
        
    }
    
    
     // MARK:  - 提供给外部show方法
    
    func show(target: UIViewController) {
        
        target.view.addSubview(self)
        self.target = target
        
        for (i ,value) in composeButtonArr.enumerate() {
        
        startAnimation(true, value: value, i: i)
        
        }
    }
    
//背景图片
    private lazy var bjImageView :UIImageView = UIImageView(image: UIImage.getScreenShot().applyLightEffect())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
         //视图大小
        self.frame.size = CGSize(width: ScreenWidth, height:SreenHeight)
        addSubview(bjImageView)
        
        addButton()
    }
    
    //加载button 
    private func addButton() {
        
        //类数
        let colNum = 3
        //button 宽
        let bwidth :CGFloat = 80
        //button 高
        let bheigt :CGFloat = 110
        
        //间距 
        let margin :CGFloat = ( width - 3 * bwidth ) / 4
        
        for (i,value) in infoArr.enumerate() {
            
            let button = PJComposeButton()
            
            button.composeMenu = value
            
            let row = i / colNum
            
            let col = i % colNum
            
            //x坐标
            
            let btnX = margin + (margin + bwidth) * CGFloat(col)
            //y坐标
            let btnY = margin + (margin + bheigt) * CGFloat(row) + SreenHeight
            
            button.frame = CGRect(x: btnX, y: btnY, width: bwidth, height: bheigt)
            
            button.setImage(UIImage(named: value.icon!), forState: .Normal)
            button.setTitle(value.title, forState: .Normal)
            
            //添加点击事件
            button.addTarget(self, action: "clickButton:", forControlEvents: .TouchUpInside)
            
            addSubview(button)
            
             composeButtonArr.append(button)
            
            
        }
        
        
        
    }
    
     // MARK:  - 点击button
    @objc func clickButton(button: PJComposeButton) {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            for btn  in self.composeButtonArr {
                
                btn.alpha = 0.2
                
                if btn == button {
                    
                    btn.transform = CGAffineTransformMakeScale(3, 3)
                }
                else {
                    
                    btn.transform = CGAffineTransformMakeScale(0.3, 0.3)
                }
                
            }

            }) { (_) -> Void in
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    for btn in self.composeButtonArr {
                        
                          btn.alpha = 1
                        
                         btn.transform = CGAffineTransformIdentity
                        
                    }
                    }, completion: { (_) -> Void in

                        
                        let classType = NSClassFromString((button.composeMenu?.className)!) as! UIViewController.Type
                        
                        let vc = classType.init()
                        
                        let nv = UINavigationController(rootViewController: vc)
                        
                        self.target?.presentViewController(nv, animated: true, completion: { () -> Void in
                            self.removeFromSuperview()
                        })
                        
    
                        
  
                        
                        
                        
   

                        
                        
                })
        }
        
    }
    
       
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for (i ,value) in composeButtonArr.reverse().enumerate() {
            
            startAnimation(false , value: value, i: i)
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(0.3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            //  结束刷新
            self.removeFromSuperview()
        })
       
        
       
    }
    
    
}
