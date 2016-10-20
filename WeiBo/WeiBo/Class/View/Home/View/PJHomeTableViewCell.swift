//
//  PJHomeTableViewCell.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/13.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
import SnapKit
let HomeCellMargin: CGFloat = 10
class PJHomeTableViewCell: UITableViewCell {
    //记录toolbar顶部约束
    var toolBarTopConstraint :Constraint?
    
    //  使用ViewModel模型
    var statusViewModel: PJStatusViewModel? {
        didSet {
            //  给原创微博视图设置需要的视图模型
            originalView.statusViewModel = statusViewModel
            
            //  卸载约束
            toolBarTopConstraint?.uninstall()
            
            //  判断是否有转发微博对象
            if statusViewModel?.status?.retweeted_status != nil {
                //  有转发微博数据
                //  给转发微博视图设置需要的视图模型, 显示转发微博视图,更新约束
                reWeetView.statusViewModel = statusViewModel
                
                reWeetView.hidden = false
                toolView.snp_updateConstraints(closure: { (make) -> Void in
                    //  记录更新的约束
                    self.toolBarTopConstraint = make.top.equalTo(reWeetView.snp_bottom).constraint
                })
                
                
            } else {
                //  没有转发微博数据, 隐藏转发微博视图,更新约束
                reWeetView.hidden = true
                
                toolView.snp_updateConstraints(closure: { (make) -> Void in
                    //  记录更新的约束
                    self.toolBarTopConstraint = make.top.equalTo(originalView.snp_bottom).constraint
                })
            }
            
            //  给toolbar视图设置需要的视图模型
            toolView.statusViewModel = statusViewModel
        }
    }

 //懒加载控件
    private lazy var originalView :PJStatusOriginalView = PJStatusOriginalView()
    private lazy var reWeetView :PJRetweetView = PJRetweetView()
    private lazy var toolView :PJToolBarView = PJToolBarView()
    
    
    
 // MARK:  - 搭建界面
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    private func setupUI() {
        
        
        contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        //  添加控件
        contentView.addSubview(originalView)
        contentView.addSubview(reWeetView)
        contentView.addSubview(toolView)
        
        originalView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(8)
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
        }
        
        reWeetView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(originalView.snp_bottom)
            make.leading.equalTo(originalView)
            make.trailing.equalTo(originalView)
        }
        
        toolView.snp_makeConstraints { (make) -> Void in
            self.toolBarTopConstraint = make.top.equalTo(reWeetView.snp_bottom).constraint
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
            make.height.equalTo(35)
        }
        
        contentView.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(toolView)
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
        }
    }
}
