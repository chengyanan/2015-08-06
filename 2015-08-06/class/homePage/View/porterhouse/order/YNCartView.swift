//
//  YNCartView.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/11.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

protocol YNCartViewDelegate {
    
    func cartViewDidClick(view: YNCartView)
}

class YNCartView: UIView {
    
    //public protorty
    
    var delegate:YNCartViewDelegate?
    
    var selectedNumber: Int = 0 {
        
        didSet {
            
            if selectedNumber > 0 {
                
                self.numberLabel.hidden = false
                self.numberLabel.text = "\(selectedNumber)"
            } else {
                
                self.numberLabel.hidden = true
            }
        }
    }

    
   override init(frame: CGRect) {
        super.init(frame: frame)
    
        var tgr: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "viewDidClick")
        self.addGestureRecognizer(tgr)
    
        self.addSubview(cartBackgroundView)
        self.addSubview(cartImageView)
        self.addSubview(numberLabel)
    
        setLayout()
    }

    func viewDidClick() {
        
        if let tempDelegate = delegate {
            
            self.delegate?.cartViewDidClick(self)
        }
        
    }

    
    
    func setLayout() {
   
        //cartBackgroundView
        Layout().addLeftConstraint(cartBackgroundView, toView: self, multiplier: 1, constant: 1)
        Layout().addBottomConstraint(cartBackgroundView, toView: self, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(cartBackgroundView, toView: nil, multiplier: 0, constant: self.cartBackgroundViewWH)
        Layout().addHeightConstraint(cartBackgroundView, toView: nil, multiplier: 0, constant: self.cartBackgroundViewWH)
        
        //cartImageView
        Layout().addCenterXConstraint(cartImageView, toView: cartBackgroundView, multiplier: 1, constant: 0)
        Layout().addCenterYConstraint(cartImageView, toView: cartBackgroundView, multiplier: 1, constant: 0)
        Layout().addHeightConstraint(cartImageView, toView: nil, multiplier: 0, constant: self.cartImageViewWH)
        Layout().addWidthConstraint(cartImageView, toView: nil, multiplier: 0, constant: self.cartImageViewWH)
        
        //numberLabel
        Layout().addTopConstraint(numberLabel, toView: cartBackgroundView, multiplier: 1, constant: 0)
        Layout().addRightConstraint(numberLabel, toView: cartBackgroundView, multiplier: 1, constant: 5)
        Layout().addWidthHeightConstraints(numberLabel, toView: nil, multiplier: 0, constant: self.numberLabelWH)
        
        
    }
    
   required init(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
    //private property
    private let cartBackgroundViewWH: CGFloat = 50
    private let cartImageViewWH: CGFloat = 25
    private let numberLabelWH: CGFloat = 18
    
    //购物车圆背景
    lazy var cartBackgroundView: UIView = {
        
        var tempView = UIView()
        tempView.setTranslatesAutoresizingMaskIntoConstraints(false)
        tempView.backgroundColor = UIColor(red: 254/255.0, green: 188/255.0, blue: 12/255.0, alpha: 1.0)
        tempView.layer.cornerRadius = self.cartBackgroundViewWH/2
        tempView.clipsToBounds = true
        return tempView
        
        }()
    
    //购物车
    private lazy var cartImageView: UIImageView = {
        
        var tempView: UIImageView = UIImageView(image: UIImage(named: "icon_cart"))
        tempView.contentMode = UIViewContentMode.ScaleAspectFit
        tempView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return tempView
        
        }()
    
    private lazy var numberLabel: UILabel = {
        // 8 * 8
        var tempView: UILabel = UILabel()
        tempView.backgroundColor = kStyleColor
        tempView.layer.cornerRadius = self.numberLabelWH/2
        tempView.textAlignment = NSTextAlignment.Center
        tempView.clipsToBounds = true
        tempView.font = UIFont.systemFontOfSize(10)
        tempView.textColor = UIColor.whiteColor()
        tempView.hidden = true
        tempView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return tempView
        
        }()

}
