//
//  PJEmotionTools.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/21.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
//一页显示个数 
let numbersOfPage = 20

class PJEmotionTools: NSObject {

    static let shareTools = PJEmotionTools()
    //构造函数私有化
    private override init(){
        super.init()
    }
    //创建bundle对象
    private lazy var emotionBundle :NSBundle = {
        
        let path = NSBundle.mainBundle().pathForResource("Emoticons.bundle", ofType: nil)!
        let bundle = NSBundle(path: path)!
        return bundle
    }()
    
    //  读取默认表情数据
    private lazy var defaultEmoticonArray: [PJEmotion] = {
        
        return self.loadEmoticonsWithPath("default/info.plist")
        
    }()
    //  读取emoji表情数据
    private lazy var emojiEmoticonArray: [PJEmotion] = {
        return self.loadEmoticonsWithPath("emoji/info.plist")
    }()
    
    //  读取浪小花表情数据
    private lazy var lxhEmoticonArray: [PJEmotion] = {
        return self.loadEmoticonsWithPath("lxh/info.plist")
    }()
    
    //  准备表情视图需要的数据
    lazy var allEmoticonArray: [[[PJEmotion]]] = {
        
        return [
            
            self.pagesWithEmotions(self.defaultEmoticonArray),
            self.pagesWithEmotions(self.emojiEmoticonArray),
            self.pagesWithEmotions(self.lxhEmoticonArray)
            
        ]
    }()
    
    
    //读取表情通用方法
    private func loadEmoticonsWithPath(subPath:String) -> [PJEmotion]{
        let bundle:NSBundle = self.emotionBundle
        let path = bundle.pathForResource(subPath, ofType: nil)
        let dicarr = NSArray(contentsOfFile: path!)
        var temparr = [PJEmotion]()
        for dic in dicarr! {
            
            let emoticon = PJEmotion(dic: dic as! [String : AnyObject])
            //  如果是图片需要处理路径
            if emoticon.type == "0" {
                let lastPath = (path! as NSString).stringByDeletingLastPathComponent
                emoticon.path = lastPath + "/" + emoticon.png!
            }
            
            
            temparr.append(emoticon)
        }
        
        return temparr
        
        }
        
        
        
    //  把表情数据拆分成一个二维数组
    private func pagesWithEmotions(emoticon: [PJEmotion]) -> [[PJEmotion]] {
        
        //  根据图片的个数计算页数
        let pages = (emoticon.count - 1) / numbersOfPage + 1
        
        var tempArray =  [[PJEmotion]]()
        for i in 0..<pages {
            // 截取的索引
            let loc = i * numbersOfPage
            // 截取的个数
            var len = numbersOfPage
            //  如果截取长度不够则取到剩余个数
            if loc + len > emoticon.count {
                len = emoticon.count - loc
            }
            
            let subArray = (emoticon as NSArray).subarrayWithRange(NSMakeRange(loc, len)) as! [PJEmotion]
            tempArray.append(subArray)
        }
        
        return tempArray
        
    }

    
    
    
    
    
    
    
    
    
    
    
}
