//
//  PJNetworkTools.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/10.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
import AFNetworking

/*
通过code 获得令牌 得到用户信息

*/
 
 


//定义枚举请求方式
enum requestType :Int{
    
    case GET
    case POST
}
class PJNetworkTools: AFHTTPSessionManager {
// 创建单例
    
    static let shareTools: PJNetworkTools = {
        
        let tools = PJNetworkTools()
        
       
        
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
    }()
    //封装请求方法
    func request(type: requestType, url: String, params: AnyObject?, callBack: (response: AnyObject?, error: NSError?)->()) {
        
        if type == .GET {
            
        
            
            
            GET(url, parameters: params, progress: nil, success: { (_, response) -> Void in
                
                callBack(response: response, error: nil)
                
                }, failure: { (_, error) -> Void in
                    callBack(response: nil, error: error)
            })
        } else {
            POST(url, parameters: params, progress: nil, success: { (_, response) -> Void in
                callBack(response: response, error: nil)
                }, failure: { (_, error) -> Void in
                    callBack(response: nil, error: error)
            })
        }
    }
}




// MARK:    -- 发送微博相关接口
extension PJNetworkTools {
    //
    func sendPicture(access_token: String, status: String, image: UIImage, callBack: (response: AnyObject?, error: NSError?) -> ()) {
        //  准备url地址
        let url = "https://upload.api.weibo.com/2/statuses/upload.json"
        //  准备参数
        let params = [
            "access_token": access_token,
            "status": status
        ]
        
        //        let imageData = UIImagePNGRepresentation(image)
        //        imageData?.writeToFile("/Users/whitcast/Desktop/1.png", atomically: true)
        //  compressionQuality质量系数  0-1, 系数越小质量越低
        let imageData = UIImageJPEGRepresentation(image, 0.5)!
        
        //  上传图片接口
        POST(url, parameters: params, constructingBodyWithBlock: { (formData) -> Void in
            
            formData.appendPartWithFileData(imageData, name: "pic", fileName: "test", mimeType: "image/jpeg")
            
            }, progress: nil, success: { (_, response) -> Void in
                callBack(response: response, error: nil)
            }) { (_, error) -> Void in
                callBack(response: nil, error: error)
        }
        
    }
    
    
    
   
    
    func sendText (access_token: String, status: String, callBack: (response: AnyObject?, error: NSError?) -> ()) {
        //  准备接口地址
        let url = "https://api.weibo.com/2/statuses/update.json"
        //  准备参数
        let params = [
            "access_token": access_token,
            "status": status
        ]
        //  使用共有函数进行网络请求数据
        request(.POST, url: url, params: params, callBack: callBack)
    }
    
}


//通过授权码获得令牌

extension PJNetworkTools{
    
    func requestAccessToken(code:String , callBack:(response:AnyObject? , error: NSError?) -> ()){
        //https://api.weibo.com/oauth2/access_token
        //请求接口地址
        let url = "https://api.weibo.com/oauth2/access_token"
        //准备请求参数
        let params = [
            "client_id": appKey,
            "client_secret": appSecret,
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": appRedirect_URi        ]
        
        //调用get请求方法
        
        request(.POST, url: url, params: params, callBack: callBack)
        
        
    }
        
    
    
//  获取用户信息
func requestUserInfo(userAccount: PJUserAount, callBack: (response: AnyObject?, error: NSError?) -> ()) {
    //  请求接口地址
    let url = "https://api.weibo.com/2/users/show.json"
    //  准备请求参数
    //  int64,跟字符串放在一起编译不通过,需要转换成字符串
    let params = [
        "access_token": userAccount.access_token!,
        "uid": "\(userAccount.uid)"
    ]
    
    
    request(.GET, url: url, params: params, callBack: callBack)
}

}

 // MARK:  - 首页微博相关接口

extension PJNetworkTools {
    
    func loadStatus(maxId: Int64 = 0,sinceId: Int64 = 0, callBack: (response: AnyObject?, error: NSError?) -> ()) {
        let url =  "https://api.weibo.com/2/statuses/friends_timeline.json"
        let params = [
            "access_token": PJUserAccountViewModel.shareUserAccount.accessToken!,
            "max_id": "\(maxId)",
            "since_id": "\(sinceId)"        ]
        
        request(.GET, url: url, params: params, callBack: callBack)

        
}



}



