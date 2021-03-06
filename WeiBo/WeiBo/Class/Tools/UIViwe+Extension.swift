//
//  UIViwe+Extension.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/9.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit
extension UIView {
    
    var x:CGFloat{
        
        get{
            
            return frame.origin.x
        }
        set{
            frame.origin.x = newValue
        }
    }
    
    var y:CGFloat{
        
        get{
            
            return frame.origin.y
        }
        set{
            
            frame.origin.y = newValue
        }
    }
    
    var width:CGFloat{
        get{
            return frame.size.width
        }
        set{
            frame.size.width = newValue
        }
    }
    var height:CGFloat{
        get{
            return frame.size.height
        }
        set{
            frame.size.height =  newValue
        }
    }
    
    var size:CGSize{
        get{
            
            return frame.size
        }
        set{
            frame.size = newValue
        }
    }
    
    
    
    var centerX:CGFloat{
        
        get{
            return center.x
        }
        set{
            center.x = newValue
        }
    }
    
    var centerY:CGFloat{
        
        get{
            return  center.y
        }
        set{
            center.y = newValue
        }
        
        
    }
    
    
    
    
    
    
    
    
    
}
