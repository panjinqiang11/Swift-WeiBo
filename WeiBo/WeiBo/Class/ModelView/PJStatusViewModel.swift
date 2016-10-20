//
//  PJStatusViewModel.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/13.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
//微博视图模型 对应cell
class PJStatusViewModel: NSObject {
    //  转发数显示内容
    var retweetStr: String?
    //  评论数显示内容
    var commentStr: String?
    //  赞数显示内容
    var unlikeStr: String?
    //  处理转发微博内容拼接"@xx:xxxx"
    var retweetContent: String?
    var status :PJStatus?
    var mbrankImage  :UIImage?
    //来源
    var sourceContent: String?
    //等级认证图片
    var verifiedtypeImage: UIImage?
    
    //构造函数
    init(status :PJStatus){
        
        super.init()
        
        
       
        self.status = status
        
        retweetStr = handleCount(status.reposts_count, defalutString: "转发")
        commentStr  = handleCount(status.comments_count, defalutString: "评论")
        unlikeStr = handleCount(status.attitudes_count, defalutString: "赞")
        //处理转发微博内容
        handleReweetContent(status)
        //处理来源
        handleSourceLabel(status.source ?? "")
        //处理会员等级图片
        handleMbrank(status.user?.mbrank ?? 0)
        //处理认证等级图片
        handleVerifiedtype(status.user?.verified_type ?? 0)
        
    
        
        
        
        
    }
    //处理认证等级图片
    private func handleVerifiedtype(verifiedtype: Int){
        switch verifiedtype {
        case 0 :
        
            verifiedtypeImage = UIImage(named: "avatar_vip")!
        
        case 2,3,5:
            verifiedtypeImage = UIImage(named: "avatar_enterprise_vip")!
        
        case 220:
            verifiedtypeImage = UIImage(named: "avatar_grassroot")!
            
        default:
        
            verifiedtypeImage = nil
            
            
        }
        
        
    }
    //处理会员等级图片
    private func handleMbrank(mbrank: Int){
        
        
        if mbrank >= 1&&mbrank <= 6{
            let img = UIImage(named: "common_icon_membership_level\(mbrank)")
            mbrankImage = img!
            
            
        }
        
    }
    //处理来源
    private func handleSourceLabel(source: String) {
        
        guard let range1 = source.rangeOfString("\">") ,let range2 = source.rangeOfString("</") else{
            
            return
            
        }
        
        sourceContent = "来自" + source.substringWithRange(range1.endIndex..<range2.startIndex)
        
        
        
    }
    
    //处理转发微博内容
    private func handleReweetContent(status: PJStatus){
        
        if status.retweeted_status != nil {
            //获取转发好有昵称
            guard let name = status.retweeted_status?.user?.screen_name,let text = status.retweeted_status?.text else{
                return
    }
            //拼接转发内容
            retweetContent = "@\(name):\(text)"
            

            
            
        }
        
        
    }
    
    //处理转发,评论,赞数据样式
    private func handleCount(count:Int,defalutString:String) -> String{
        
        
        if count > 0 {
            if count > 10000 {
                let result = Float(count / 1000) / 10
                var resultStr = "\(result)万"
                
                if resultStr.containsString(".0"){
                    resultStr = resultStr.stringByReplacingOccurrencesOfString(".0", withString: "")
                }
                return resultStr
            }else {
                
                return "\(count)"
            }
            
            
        }else {
            
            return defalutString
        }
    }
    
}
