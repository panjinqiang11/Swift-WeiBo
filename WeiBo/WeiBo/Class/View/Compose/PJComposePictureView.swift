//
//  PJComposePictureView.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/20.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit


private let PJComposePictureViewCellIdentifier = "PJComposePictureViewCellIdentifier"

class PJComposePictureView: UICollectionView {

    var addClosuce :(() -> ())?
    
    //图片数组
    lazy var images :[UIImage] = [UIImage]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flow = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: flow)
        
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI(){
        
        
        //注册cell
        registerClass(PJComposePictureViewCell.self, forCellWithReuseIdentifier: PJComposePictureViewCellIdentifier)
        //设置代理

       dataSource = self
        
        delegate = self

        self.hidden = true
        
    
                
    }
    
    
    func addImage(image :UIImage){
        
       self.hidden = false
        
        images.append(image)
        
        
        reloadData()
    }
    //设置布局
    override func layoutSubviews() {
        
        super.layoutSubviews()
        let  flow = collectionViewLayout as! UICollectionViewFlowLayout
        
        //  每项之间的间距
        let itemMargin: CGFloat = 5
        //  每项大小
        let itemWidth = (width - 2 * itemMargin) / 3
        
        flow.itemSize = CGSizeMake(itemWidth, itemWidth)
        
        
        flow.minimumLineSpacing = itemMargin
        flow.minimumInteritemSpacing = itemMargin
        

    }
    
   
    
    
}

extension PJComposePictureView:UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if images.count == 9 || images.count == 0 {
            return images.count
        }
        


        return images.count + 1
    }
     func  collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
    
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PJComposePictureViewCellIdentifier, forIndexPath: indexPath) as! PJComposePictureViewCell
        
        
        if indexPath.item == images.count{
            
            cell.image = nil
        }else{
            
          cell.image = images[indexPath.item]
        }
        
        cell.deleteClosurce = {
            
            self.images.removeAtIndex(indexPath.item)
            if self.images.count == 0 {
                
                self.hidden = true
            }
            
            self.reloadData()
        }
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //加号图片
        if indexPath.item == images.count {
            
              collectionView.deselectItemAtIndexPath(indexPath, animated: true)
            
            addClosuce?()
        }
        
        
    }
    
    
    
}




class PJComposePictureViewCell :UICollectionViewCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    var deleteClosurce :(() -> ())?
    var image: UIImage? {
        
        didSet{
            
            if image == nil {
                
                cellBjImage.image = UIImage(named: "compose_pic_add")
                deleButton.hidden = true
                cellBjImage.highlightedImage = UIImage(named: "compose_pic_add_highlighted")
                
            }else {
                
                deleButton.hidden = false
                cellBjImage.image = image
                
                cellBjImage.highlightedImage = nil
            }
        }
    }
    
    
    private lazy var cellBjImage :UIImageView = UIImageView(image: UIImage(named: "timeline_image_placeholder"))
        

    
    private lazy var deleButton :UIButton = {
        
        let btn = UIButton()
        btn.addTarget(self, action: "deleteButton", forControlEvents: .TouchUpInside)
        
        btn.setImage(UIImage(named: "compose_photo_close"), forState: .Normal)
        return btn
        
    }()
    
  private func setupUI(){
    
    
    contentView.addSubview(cellBjImage)
    contentView.addSubview(deleButton)
    cellBjImage.snp_makeConstraints { (make) -> Void in
        make.edges.equalTo(contentView).offset(UIEdgeInsetsZero)
    }
    
    deleButton.snp_makeConstraints { (make) -> Void in
        make.top.equalTo(cellBjImage)
        make.trailing.equalTo(cellBjImage)
    }
    
    }
    @objc private func deleteButton(){
        deleteClosurce?()
        
    }
    
    
    
}










