//
//  PJDiscoverSearchView.swift
//  WeiBo
//
//  Created by 潘金强 on 16/7/14.
//  Copyright © 2016年 潘金强. All rights reserved.
//

import UIKit

class PJDiscoverSearchView: UIView,UITextFieldDelegate {

    @IBOutlet weak var rightconstraint: NSLayoutConstraint!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var textFiled: UITextField!
    
    
    //类方法加载xib
    class func  searchView() ->  PJDiscoverSearchView{
        
              return UINib(nibName: "PJDiscoverSearchView", bundle: nil).instantiateWithOwner(nil, options: nil).last as! PJDiscoverSearchView
    }
   
    
    
    @IBAction func cancelAction(sender: AnyObject) {
        
        textFiled.resignFirstResponder()
        rightconstraint.constant = 0
        UIView.animateWithDuration(0.25) { () -> Void in
            self.layoutIfNeeded()
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
      rightconstraint.constant = cancelButton.width
        UIView.animateWithDuration(0.25) { () -> Void in
            self.layoutIfNeeded()
        }
    }
}
