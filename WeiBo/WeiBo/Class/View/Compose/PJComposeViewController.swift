//
//  PJComposeViewController.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/19.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
import SVProgressHUD
class PJComposeViewController: UIViewController {
  //标题
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.grayColor()
        label.font = UIFont.systemFontOfSize(15)
        label.textAlignment = .Center
        label.numberOfLines = 0
        
        if let name = PJUserAccountViewModel.shareUserAccount.userAccount?.name {
            
            let title = "发微博\n\(name)"
            let attibuteStr = NSMutableAttributedString(string: title)
            
            let range = (title as NSString).rangeOfString(name)
            
            
            attibuteStr.addAttributes([NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSFontAttributeName: UIFont.systemFontOfSize(12)], range: range)
            


            label.attributedText = attibuteStr
            
            
        }else {
            
            label.text = "发微博"
        }
        label.sizeToFit()
       
          return label
        
    }()
    
    private lazy var pictureView :PJComposePictureView = {
        
        let pic = PJComposePictureView()
                
        return pic
    }()
    
    //  右侧按钮(发送按钮)
    private lazy var rightButton: UIButton = {
        
        let button = UIButton()
        
    
        //  添加点击事件
        button.addTarget(self, action: "sendAction", forControlEvents: .TouchUpInside)
        button.setBackgroundImage(UIImage(named: "common_button_orange"), forState: .Normal)
        button.setBackgroundImage(UIImage(named: "common_button_orange_highlighted"), forState: .Highlighted)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Disabled)
        
        button.setTitle("发送", forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.setTitleColor(UIColor.grayColor(), forState: .Disabled)
        button.size = CGSize(width: 45, height: 30)
        //  因为button被UIBarButtonItem,这样设置没有作用
        //        button.enabled = false
        return button
        
    }()
    
    
    

    
    private func setNAUI() {
        
        navigationItem.titleView = titleLabel
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelAction")
        
        navigationItem.rightBarButtonItem?.enabled = false
    }

    @objc private func cancelAction(){
        
        self.view.endEditing(true)
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
     // MARK:  -  发送按钮
    @objc private func sendAction() {
        //发送文字
        if pictureView.images.count == 0 {
            let access = PJUserAccountViewModel.shareUserAccount.accessToken
            
            let status = textView.text
            
            PJNetworkTools.shareTools.sendText(access!, status: status!, callBack: { (response, error) -> () in
                if error == nil{
                    
                    //  发送成功
                    SVProgressHUD.showSuccessWithStatus("发送成功")

                    
                }else {
                    
                    
                    SVProgressHUD.showErrorWithStatus("发送失败")
                }
            })

        }else {
            
            //发送图片
            let access = PJUserAccountViewModel.shareUserAccount.accessToken!
            
            let status = textView.text!
            
            let image = pictureView.images.first!

            
            PJNetworkTools.shareTools.sendPicture(access, status: status, image: image, callBack: { (response, error) -> () in
                if error == nil{
                    
                    //  发送成功
                    SVProgressHUD.showSuccessWithStatus("发送成功")
                    
                    
                }else {
                    
                    
                    SVProgressHUD.showErrorWithStatus("发送失败")
                }

            })
        }
        
        
    }
    
    deinit{
        
        
        NSNotificationCenter.defaultCenter().removeObserver(self)

    }
    
    //懒加载toolBar
    private lazy var bottomToolBar :PJComposeToolBar = {
        let tool = PJComposeToolBar(frame: CGRectZero)
        
        return tool
        
    }()
    
    //懒加载textVie
    private lazy var textView :PJComposeTextView = {
        
        let text = PJComposeTextView()
        
        text.delegate = self
        
        text.alwaysBounceVertical = true
        
        return text
        
        
    }()
    
    
    //懒加载表情键盘
    private lazy var keyView :PJEmotionView = {
        
        let key = PJEmotionView()
        key.size = CGSize(width: self.textView.width, height: 216)
        return key
    }()
    
        
    private func setUI() {
        
        //监听键盘的改变
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        //监听键盘上button 的点击
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "clikKeyboardButton:", name: "clickKeyBoardButtonNotification", object: nil)
        
        
        
        setNAUI()

        view.addSubview(textView)
        view.addSubview(bottomToolBar)
        
        textView.addSubview(pictureView)
        
        textView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(bottomToolBar.snp_top)
        }
        
        
        bottomToolBar.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(view)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.height.equalTo(30)
            
        }
        
        
        pictureView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(textView).offset(100)
            make.leading.equalTo(textView).offset(10)
            make.width.equalTo(textView).offset(-20)
            make.height.equalTo(textView.snp_width).offset(-20)
        }
        
        pictureView.addClosuce = {

     self.didSelectPicture()
}

        
        bottomToolBar.selectClosure = {[weak self] (type :composeToolBarButtonType) in
            switch type {
                
                
            case .Picture :
                print("图片")
                self?.didSelectPicture()
            case .Mention :
                print("@")
            case .Trend :
                print("话题")
            case .Emotion :
                print("表情")
                self?.didSelectedKey()
            case .Add :
                print("加号")
            }
            
        }
        
        
        

    }
    
  // MARK:  - 点击键盘上的button
   @objc private func clikKeyboardButton(noti: NSNotification){
   
    
   let emoticon = noti.object as! PJEmotion
    //如果是图片
    if emoticon.type == "0" {
        
        
        let originalAttributedStr = NSMutableAttributedString(attributedString: textView.attributedText)

        //获取图片
        let img = UIImage(named: emoticon.png!)
        //创建附件
        let attachment = NSTextAttachment()
        attachment.image = img
        
        //设置图片大小
        attachment.bounds = CGRect(x: 0, y: -4, width: (textView.font?.lineHeight) ?? 0, height: (textView.font?.lineHeight) ?? 0)
        
        //创建富文本
        let attributStr = NSAttributedString(attachment: attachment)
        
        
        //text添加富文本
        originalAttributedStr.appendAttributedString(attributStr)
        
        textView.attributedText = originalAttributedStr
        

        //指定富文本大小
        originalAttributedStr.addAttribute(NSFontAttributeName, value: textView.font!, range: NSMakeRange(0, originalAttributedStr.length))
        
        
        
          NSNotificationCenter.defaultCenter().postNotificationName(UITextViewTextDidChangeNotification, object: nil)
        
          self.navigationItem.rightBarButtonItem?.enabled = textView.hasText()
    }else{//emoji
    let emoji = (emoticon.code! as NSString).emoji()
        textView.insertText(emoji)
            }
    
    
        
    }
    
 // MARK:  - 改变键盘
    
    private func didSelectedKey() {
        
        if textView.inputView == nil{
            
            textView.inputView = keyView
            bottomToolBar.showEnmotion(true)
        
        }else{
            
            textView.inputView = nil //设置成系统的
            
            bottomToolBar.showEnmotion(false)
        }
        
        textView.becomeFirstResponder()
        
        textView.reloadInputViews()
        
    }
    
     // MARK:  - 键盘改变
    
    @objc private func keyboardChangeFrame(noti: NSNotification){
        
        let keyboardFrame = (noti.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        let duration = (noti.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let barY = keyboardFrame.origin.y - SreenHeight
        
        bottomToolBar.snp_updateConstraints { (make) -> Void in
            make.bottom.equalTo(barY)
        }
     
        UIView.animateWithDuration(duration) { () -> Void in
            self.view.layoutIfNeeded()
        }
      
    }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        //self.automaticallyAdjustsScrollViewInsets = false
        
        setUI()
    }

   
}

extension PJComposeViewController :UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    func didSelectPicture(){
        
        let picController = UIImagePickerController()
        picController.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            //支持相机
            picController.sourceType = .Camera
        }else {
            //不支持相机 使用图库
            picController.sourceType = .PhotoLibrary
        }
        
        if UIImagePickerController.isCameraDeviceAvailable(.Front){
            
            print("支持前摄像头")
            
        }else  if UIImagePickerController.isCameraDeviceAvailable(.Rear){
            
            print("支持后摄像头")
        }else {
            
            print("不支持前后摄像头")
            
        }
        //是否支持编辑图片
     // picController.allowsEditing = false
        //跳转控制器
        presentViewController(picController, animated: true, completion: nil)
        
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        let img = scaleImage(image, scaleWidth: 200)
        
        pictureView.addImage(img)
        
        
        
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true , completion: nil)
    }
    
    private func scaleImage(image: UIImage,scaleWidth: CGFloat) -> UIImage{
        
        let scaleHeight = scaleWidth * image.size.height / image.size.width
        
        let size = CGSizeMake(scaleWidth,scaleHeight)
        
        //根据图片上下文获得图片
        
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return img
        
        
        
    }

    
    
    
}

extension PJComposeViewController :UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        
        
        
        self.navigationItem.rightBarButtonItem?.enabled = textView.hasText()
        
        
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        self.view.endEditing(true)
    }
    
    
}






