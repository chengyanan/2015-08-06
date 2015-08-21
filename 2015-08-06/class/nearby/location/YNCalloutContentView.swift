//
//  YNCalloutContentView.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/21.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

class YNCalloutContentView: UIView {

    lazy var imageView:UIImageView = {
        var tempImageView = UIImageView()
        tempImageView.contentMode = UIViewContentMode.ScaleToFill
        return tempImageView
        }()
    lazy var titleLabel:UILabel = {
        var tempLabel = UILabel()
        tempLabel.backgroundColor = UIColor.whiteColor()
        return tempLabel
        }()
    
    var dataModel: Restaurant? {
  
        willSet {
       
            self.titleLabel.text = ""
        }
        
        didSet {
       
            if let tempImage = dataModel?.image {
                
//                Network.getImageWithURL(tempImage, success: { (data) -> Void in
//                    
//
//                })
                self.imageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: tempImage)!)!)
                                
               
           
            }
            
            titleLabel.text = dataModel?.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        
        imageView.frame = CGRectMake(6, 6, 50, 50)
        
        titleLabel.frame = CGRectMake(6 + 50, 6, frame.size.width - 6-50, 30)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
