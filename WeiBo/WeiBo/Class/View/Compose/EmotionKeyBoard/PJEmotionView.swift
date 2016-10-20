//
//  PJEmotionView.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/21.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
import SnapKit

let PJEmotionViewCell = "PJEmotionViewCell"
class PJEmotionView: UIView {

     private lazy var toolView = PJKeyBoardBar(frame: CGRectZero)
    private lazy var keyBoardView :UICollectionView = {
        
        
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .Horizontal
    
        let key :UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: flow)
        key.pagingEnabled = true
        key.showsHorizontalScrollIndicator = false
        key.showsVerticalScrollIndicator = false
        key.bounces = false
        
        key.dataSource = self
        
        key.delegate = self
        
        key.registerClass(PJEmotionCell.self, forCellWithReuseIdentifier: PJEmotionViewCell)
        return key

    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        let flow = keyBoardView.collectionViewLayout as? UICollectionViewFlowLayout
        flow?.minimumLineSpacing = 0
        flow?.minimumInteritemSpacing = 0
        flow?.itemSize = keyBoardView.size
    }
    
    private func setupUI(){
        addSubview(toolView)
        addSubview(keyBoardView)
        keyBoardView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(toolView.snp_top)
        }
        toolView.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo(30)
        }
    //点击按钮闭包
        toolView.selectButton = { [weak self] (type :EmotionType) in
            
            var index :NSIndexPath = NSIndexPath()
            
            switch type {
                
            case .Normal :
                print("默认")
                index = NSIndexPath(forItem: 0, inSection: 0)
                
            case .Emoji :
                print("emoji")
                index = NSIndexPath(forItem: 0, inSection: 1)
            case .Lxh :
                print("浪小花")
                index = NSIndexPath(forItem: 0, inSection: 2)
                
            }
         self!.keyBoardView.scrollToItemAtIndexPath(index, atScrollPosition: UICollectionViewScrollPosition.None, animated: false)
    
            
        }
    }
}

extension PJEmotionView :UICollectionViewDelegate{
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let cells = keyBoardView.visibleCells().sort { (firstCell, secondCell) -> Bool in
            return firstCell.x < secondCell.x
        }
        
        //判断哪个cell显示多
        if  cells.count == 2 {
            
            let firstCell = cells.first!
            let secondCell = cells.last!
            //显示部分
            let firstCellContentOffset = abs(firstCell.x - scrollView.contentOffset.x)
            let secondCellContentOffset = secondCell.x - scrollView.contentOffset.x
//            print(firstCellContentOffset)
//            print(secondCellContentOffset)
            
            let cell :UICollectionViewCell
            
            if firstCellContentOffset > secondCellContentOffset {
                
                cell = firstCell
            }else {
                
                cell = secondCell
            }
            //取到cell 的位置
            guard let indexPath = keyBoardView.indexPathForCell(cell) else {
                
                return
            }
            
            
           toolView.seleButton(indexPath.section)
            
            }
            
   
        
        
        
        
        
        
        
    }
}

extension PJEmotionView :UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return PJEmotionTools.shareTools.allEmoticonArray.count
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PJEmotionTools.shareTools.allEmoticonArray[section].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
   
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PJEmotionViewCell, forIndexPath: indexPath) as! PJEmotionCell
        
        
        
       cell.backgroundColor = UIColor.whiteColor()
        
        cell.emotions = PJEmotionTools.shareTools.allEmoticonArray[indexPath.section][indexPath.row]
        
        
        return cell
        
    }
    
    
}




