//
//  PJRefreshController.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/17.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
//定义控件高度
private var PJRefreshHeight :CGFloat = 50
//下拉刷新枚举类型
enum PJRefreshControlState :Int{
    //下拉刷新状态
    case  Normal = 0
    //松手就刷新状态
    case Pulling = 1
    //正在刷新状态
    case Refreshing = 2
    
    
    
}



//自定义下拉刷新控件
class PJRefreshController: UIControl {
//当前状态
    var refreshState :PJRefreshControlState = .Normal {
        
        didSet{
            switch refreshState {
                
            case .Normal:
                
                iconImageView.hidden = false
                contentLabel.text = "下拉刷新"
                indicatorImageView.stopAnimating()
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.iconImageView.transform = CGAffineTransformIdentity
                })
                
                if oldValue == .Refreshing {
                    
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        self.currentScrollView?.contentInset.top -= PJRefreshHeight
                    })
                }
            case .Pulling:
                contentLabel.text = "松手刷新"
                indicatorImageView.stopAnimating()
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    //箭头调转
                    self.iconImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))

                })
                
            case .Refreshing:
                contentLabel.text = "正在刷新"
                iconImageView.hidden = true
                indicatorImageView.startAnimating()
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.currentScrollView?.contentInset.top += PJRefreshHeight
                })
                //通知外界进行加载
                sendActionsForControlEvents(.ValueChanged)
            }
        }
    }
    //当前滚动视图
    var currentScrollView : UIScrollView?
    
     // MARK:  - 懒加载控件
    //下拉箭头
    private lazy var iconImageView :UIImageView = UIImageView(image: UIImage(named: "tableview_pull_refresh"))
    //内容
    private lazy var contentLabel :UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(12)
        label.textColor = UIColor.grayColor()
        label.text = "下拉刷新"
        
        return label
        
    }()
    //风火轮
    private lazy var indicatorImageView :UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
      setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   //设置控件约束
    private func setupUI(){
        
    //设置背景颜色
    backgroundColor = RandomColor()
        
    addSubview(iconImageView)
    addSubview(indicatorImageView)
    addSubview(contentLabel)
        
    //使用系统约束布局
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: contentLabel, attribute: .Leading, relatedBy: .Equal, toItem: iconImageView, attribute: .Trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: contentLabel, attribute: .CenterY, relatedBy: .Equal, toItem: iconImageView, attribute: .CenterY, multiplier: 1, constant: 0))
        
        indicatorImageView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: indicatorImageView, attribute: .CenterX, relatedBy: .Equal, toItem: iconImageView, attribute: .CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: indicatorImageView, attribute: .CenterY, relatedBy: .Equal, toItem: iconImageView, attribute: .CenterY, multiplier: 1, constant: 0))
        

        
    }
    //将要 添加到哪个控件上时调用
    override func willMoveToSuperview(newSuperview: UIView?) {
        
        //判断其父控件能否滚动
        guard let scorllView = newSuperview as? UIScrollView else{
            
            return
        }
       //设置自己的frame
        self.frame.size = CGSize(width:scorllView.frame.size.width, height: PJRefreshHeight)
        self.frame.origin.y = -PJRefreshHeight
        
        //使用kvo监听其父控件的滚动
        
        scorllView.addObserver(self, forKeyPath: "contentOffset", options: [.New], context: nil)
        currentScrollView = scorllView
        }
    
    //监听方法
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        guard let scrollView = currentScrollView else{
            return
        }
        //判断逻辑
        
        if scrollView.dragging {
        //松手刷新状态
            
            if scrollView.contentOffset.y < -(scrollView.contentInset.top + PJRefreshHeight) && refreshState == .Normal {
                refreshState = .Pulling
            }else if scrollView.contentOffset.y > -(scrollView.contentInset.top + PJRefreshHeight) && refreshState == .Pulling{
                
                refreshState = .Normal
            }else {
                if refreshState == .Pulling {
                    refreshState = .Refreshing}
            }
            
        
        
        }
        
    }
    //结束刷新
    func endRefreshing(){
        
        refreshState = .Normal
    }
    
    //移除kvo
    deinit{
        
       currentScrollView?.removeObserver(self, forKeyPath: "contentOffset")
        
    }
}
