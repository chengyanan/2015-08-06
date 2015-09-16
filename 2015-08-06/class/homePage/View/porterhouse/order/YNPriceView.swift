//
//  YNPriceView.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/11.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

protocol PriceViewDelegate {
    
    func priceViewDidClick(view: PriceView)
}

class PriceView: UIView {
    
    //public protorty
    
    var delegate: PriceViewDelegate?
    
    var totalPrice: Float = 0 {
        
        didSet {
            
            self.totalPriceLable.text = "¥\(totalPrice)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 56/255.0, green: 60/255.0, blue: 67/255.0, alpha: 0.9)
        
        var tgr: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "viewDidClick")
        
        self.addGestureRecognizer(tgr)
        
        self.addSubview(totalPriceLable)
        
        setupLayout()
    }
    
    func viewDidClick() {
        
        if let tempDelegate = delegate {
       
            self.delegate?.priceViewDidClick(self)
        }
        
    }
    
    func setupLayout() {
        
        //totalPriceLable
        Layout().addLeftConstraint(totalPriceLable, toView: self, multiplier: 1, constant: 70)
        Layout().addTopConstraint(totalPriceLable, toView: self, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(totalPriceLable, toView: self, multiplier: 1, constant: 0)
        Layout().addRightConstraint(totalPriceLable, toView: self, multiplier: 1, constant: 0)
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var totalPriceLable: UILabel = {
        // 8 * 8
        var tempView: UILabel = UILabel()
        tempView.text = "¥0"
        tempView.font = UIFont.systemFontOfSize(20)
        tempView.textColor = UIColor.whiteColor()
        tempView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return tempView
        
        }()
    
}
