//
//  YNTestFiledExtension.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/7.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func setTextFiledWithLeftImageName(_ leftImageName: String?, customRightView: UIView?, placeHolder: String?, keyBoardTypePara: UIKeyboardType){
        
        self.clearButtonMode = UITextFieldViewMode.whileEditing
        self.backgroundColor = UIColor.white
        self.translatesAutoresizingMaskIntoConstraints = false
       
        if let _ = leftImageName {
            
            let leftImageView = UIImageView(image: UIImage(named: leftImageName!))
            leftImageView.frame = CGRect(x: 0, y: 0, width: 38, height: 30)
            self.leftView = leftImageView
            self.leftView?.contentMode = UIViewContentMode.scaleAspectFit
            self.leftViewMode = UITextFieldViewMode.always
        }
        
        if let _ = customRightView {
        
            self.rightView = customRightView
            self.rightViewMode = UITextFieldViewMode.always
        }
        
        if placeHolder != nil {
            self.placeholder = placeHolder
        }
        
        self.keyboardType = keyBoardTypePara
        
    }
    
}
