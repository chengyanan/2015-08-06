//
//  YNNearbyTitleView.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/21.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

class YNNearbyTitleView: UIView {

    let kIndicatorWidth: CGFloat = 20
    
    lazy var indicator: UIActivityIndicatorView = {
        
        var tempIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        tempIndicator.startAnimating()
        return tempIndicator
        
        }()
    lazy var titleLabel: UILabel = {
        var tempLabel = UILabel()
        tempLabel.textColor = kStyleColor
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.text = "我附近的热门商家"
        
//        tempLabel.sizeToFit()
        
        return tempLabel
        }()
    
    
    var indicatorX: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleLabel)
        
        titleLabel.frame = self.bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func calculateIndicatorX() {
        
        let selfWidth: CGFloat = frame.size.width
        let labelWidth: CGFloat = titleLabel.frame.size.width
        let indicatorWidth: CGFloat = indicator.bounds.size.width
        let plus = selfWidth - labelWidth - indicatorWidth
        indicatorX = plus/2

    }
    
    func start() {
        
        self.titleLabel.textAlignment = NSTextAlignment.left
        self.addSubview(indicator)
        
        self.bringSubview(toFront: self.titleLabel)
        
        self.titleLabel.text = "加载中..."
        self.titleLabel.sizeToFit()
        
        calculateIndicatorX()
        
        if let _ = self.indicatorX {
       
            self.indicator.frame = CGRect(x: self.indicatorX!, y: 0, width: kIndicatorWidth, height: 44)
            
            let titileX = kIndicatorWidth + self.indicatorX!
            
            self.titleLabel.frame = CGRect(x: titileX, y: 0, width: self.frame.size.width - kIndicatorWidth, height: 44)
            
        }else {
       
            print("初始化位置不对", terminator: "")
        }
    
    }
    
    func end() {
        
        
        self.indicator.removeFromSuperview()
        self.titleLabel.text = "我附近的热门商家"
        self.titleLabel.textAlignment = NSTextAlignment.center
        self.titleLabel.frame = self.bounds
        
//        UIView.animateWithDuration(1, animations: { () -> Void in
//        
//            
//            
//        }) { (finish) -> Void in
//            
//            
//            
//        }
        
    }
}
