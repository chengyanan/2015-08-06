//
//  YNCartView.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/11.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

protocol YNCartViewDelegate {
    
    func cartViewDidClick(_ view: YNCartView)
}

class YNCartView: UIView {
    
    //public protorty
    
    var delegate:YNCartViewDelegate?
    
    var selectedNumber: Int = 0 {
        
        didSet {
            
            if selectedNumber > 0 {
                
                self.numberLabel.isHidden = false
                self.numberLabel.text = "\(selectedNumber)"
            } else {
                
                self.numberLabel.isHidden = true
            }
        }
    }

    
   override init(frame: CGRect) {
        super.init(frame: frame)
    
        let tgr: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(YNCartView.viewDidClick))
        self.addGestureRecognizer(tgr)
    
        self.addSubview(cartBackgroundView)
        self.addSubview(cartImageView)
        self.addSubview(numberLabel)
    
        setLayout()
    }

    func viewDidClick() {
        
        if let _ = delegate {
            
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
    
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
    //private property
    fileprivate let cartBackgroundViewWH: CGFloat = 50
    fileprivate let cartImageViewWH: CGFloat = 25
    fileprivate let numberLabelWH: CGFloat = 18
    
    //购物车圆背景
    lazy var cartBackgroundView: UIView = {
        
        var tempView = UIView()
        tempView.translatesAutoresizingMaskIntoConstraints = false
        tempView.backgroundColor = UIColor(red: 254/255.0, green: 188/255.0, blue: 12/255.0, alpha: 1.0)
        tempView.layer.cornerRadius = self.cartBackgroundViewWH/2
        tempView.clipsToBounds = true
        return tempView
        
        }()
    
    //购物车
    fileprivate lazy var cartImageView: UIImageView = {
        
        var tempView: UIImageView = UIImageView(image: UIImage(named: "icon_cart"))
        tempView.contentMode = UIViewContentMode.scaleAspectFit
        tempView.translatesAutoresizingMaskIntoConstraints = false
        return tempView
        
        }()
    
    fileprivate lazy var numberLabel: UILabel = {
        // 8 * 8
        var tempView: UILabel = UILabel()
        tempView.backgroundColor = kStyleColor
        tempView.layer.cornerRadius = self.numberLabelWH/2
        tempView.textAlignment = NSTextAlignment.center
        tempView.clipsToBounds = true
        tempView.font = UIFont.systemFont(ofSize: 10)
        tempView.textColor = UIColor.white
        tempView.isHidden = true
        tempView.translatesAutoresizingMaskIntoConstraints = false
        return tempView
        
        }()

}
