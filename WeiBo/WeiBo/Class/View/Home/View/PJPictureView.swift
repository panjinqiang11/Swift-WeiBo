//
//  PJPictureView.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/15.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
import SnapKit
//cell标记
private let cellId = "PJPictureCell"
//  每项的间距
private let itemMargin: CGFloat = 5
//  每项的宽度
private let itemWidth: CGFloat = (ScreenWidth - 2 * HomeCellMargin - 2 * itemMargin) / 3
//配图视图
class PJPictureView: UICollectionView {

  //数据
    var picInfo :[PJStatusPicInfo]?{
    
    didSet{
    
        
        messageLabel.text = "\(picInfo?.count ?? 0)"
        
        

        
        let size  = calPictureSize(picInfo?.count ?? 0)
        
        self.snp_updateConstraints { (make) -> Void in
            
            make.size.equalTo(size)
        }
        self.reloadData()
    }
    
    }
    
    
    // 根据图片个数设置图片大小
    private func calPictureSize(count :Int) -> CGSize{
        
        let cols = count > 3 ? 3 : count//列数
        


        let rows = (count - 1)/3 + 1//行数
        

        
        //  计算当前配图的一个宽度
        let width = CGFloat(cols) * itemWidth + CGFloat(cols - 1) * itemMargin
        //  计算当前配图的一个高度
        let height = CGFloat(rows) * itemWidth + CGFloat(rows - 1) * itemMargin
        
        let size = CGSize(width: width, height: height)
        

      
        
        return size
        
    }
        
        
        
        
    
    
    
    
    private lazy var messageLabel :UILabel = UILabel(textColor: UIColor.orangeColor(), fontSize: 13)
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
       let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        layout.minimumLineSpacing = itemMargin
        
        layout.minimumInteritemSpacing = itemMargin

        
        super.init(frame: frame, collectionViewLayout: layout)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupUI(){
        
        registerClass(PJPicViewCell.self, forCellWithReuseIdentifier: cellId)
       //添加控件
      addSubview(messageLabel)
        
        dataSource = self
       //设置控件约束
      messageLabel.snp_makeConstraints { (make) -> Void in
        make.center.equalTo(self)
        }
    }
    
  }

//代理方法

extension PJPictureView :UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        

        return picInfo?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
       let  cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! PJPicViewCell
        
        cell.pic = picInfo![indexPath.item]
        
        return cell
    }
}



//自定义cell

class PJPicViewCell:UICollectionViewCell{
    var pic : PJStatusPicInfo?{
        
        didSet{
            
            if let imgUrl = pic?.thumbnail_pic{
                

                
                img.sd_setImageWithURL(NSURL(string: imgUrl), placeholderImage: UIImage(named: "timeline_image_placeholder"))
                
                gitImage.hidden = imgUrl.hasSuffix(".gif")
            }
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var gitImage :UIImageView = UIImageView(image: UIImage(named: "timeline_image_gif"))
    
    private lazy var img:UIImageView = {
        
        let img = UIImageView(image: UIImage(named: "timeline_image_placeholder"))
        
        img.contentMode = UIViewContentMode.ScaleAspectFill
        //裁剪多余部分
        img.clipsToBounds = true
        return img
    }()
    
    private func setUI(){
        
        addSubview(gitImage)
        addSubview(img)
        img.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView).offset(UIEdgeInsetsZero)
        }
        gitImage.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(img)
            make.trailing.equalTo(img)
        }
        
    }
    
    
}








