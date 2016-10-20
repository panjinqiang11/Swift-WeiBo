//
//  PJOAuthController.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/10.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit

import AFNetworking

import SVProgressHUD

//App Key：3193815114
let appKey = "3193815114"


//App Secret：fc61d42554fab34fbc633f79b6d3def6
let appSecret = "fc61d42554fab34fbc633f79b6d3def6"
//授权回调页：http://www.itcast.cn
let appRedirect_URi = "http://www.itcast.cn"

class PJOAuthController: UIViewController {
    
    
    //懒加载webview
    private lazy var webView :UIWebView = UIWebView()
    
    override func loadView() {
        
        
        //设置代理
        webView.delegate = self
        
        view = webView
        
        
        
    }
    //https://api.weibo.com/oauth2/authorize?client_id=3193815114&redirect_uri=http://www.itcast.cn
    //加载网页
    private func requestLogin(){
        
        //请求地址
        let url = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(appRedirect_URi)"
        
        //准备请求
        let request = NSURLRequest(URL: NSURL(string: url)!)
        
        //加载请求
        
        webView.loadRequest(request)
        
    }
    
           
        
            
        
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

       view.backgroundColor = UIColor.whiteColor()
        
        setUI()
        
        //调用加载网页方法
        requestLogin()
      
    }
    
     // MARK:  - 添加左右item
    private  func setUI()  {
        //添加标题
        navigationItem.title = "微博登录"
        //添加左侧的取消按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", target: self, action: "cancel")
        
        //添加右侧自动填充按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, action: "autoFill")
    }
    
     // MARK:  - 点击取消
    @objc  private func cancel(){
        //返回上级控制器
        dismissViewControllerAnimated(true , completion: nil)
    }
    
     // MARK:  - 点击自动填充
    @objc private func autoFill(){
        
        webView.stringByEvaluatingJavaScriptFromString("document.getElementById('userId').value = 15527440533; document.getElementById('passwd').value = 'pan13886177830jq'")
        
        
    }

   }
    // MARK:  - 实现webview代理方法

extension PJOAuthController:UIWebViewDelegate{
    //将要加载请求
    
    //Optional(http://www.itcast.cn/?code=d2a49a6a18d7277c8481bfd884358f6d)
    

    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        
        guard  let url = request.URL else{
            
            return false
        }
        
        if !url.absoluteString.hasPrefix(appRedirect_URi) {
            
            return true
        }
        
        //代码执行到此一定能得到请求
        //截取字符串得到授权码
     
        if let query = url.query where query.hasPrefix("code=")  {

       
        let code = query.substringFromIndex("code=".endIndex)
            
         //code 为授权码 调用方法得到令牌
        
        //通过accessToken过得用户信息
       // requestAccesstoken(code)
            
            PJUserAccountViewModel.shareUserAccount.requestAccesstoken(code, callBack: { (isSuccess) -> () in
                if isSuccess {
                    print("登陆成功")
                    self.dismissViewControllerAnimated(true , completion: { () -> Void in
                        NSNotificationCenter.defaultCenter().postNotificationName(SwitchRootVCNotification,object: self)
                    })
                    
                }else {
                    print("登陆失败")
                }
            })

        
        }else{
            dismissViewControllerAnimated(true , completion: nil)
        }
        
        return  true
    }
    
    
    
    
    //开始加载
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    //加载完成
    func webViewDidFinishLoad(webView: UIWebView){
        SVProgressHUD.dismiss()
        
    }
    //加载失败
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?){
        
       
        SVProgressHUD.dismiss()
        
    }
    
}







