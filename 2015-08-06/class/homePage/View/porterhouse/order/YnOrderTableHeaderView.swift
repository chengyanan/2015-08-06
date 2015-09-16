//
//  YnOrderTableHeaderView.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/15.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

class YnOrderTableHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 228/255.0, green: 228/255.0, blue: 228/255.0, alpha: 1)
        
        self.addSubview(nameLabel)
        setupLayout()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
   
        //nameLabel
        Layout().addTopConstraint(nameLabel, toView: self, multiplier: 1, constant: 0)
        Layout().addLeftConstraint(nameLabel, toView: self, multiplier: 1, constant: 12)
        Layout().addBottomConstraint(nameLabel, toView: self, multiplier: 1, constant: 0)
        Layout().addRightConstraint(nameLabel, toView: self, multiplier: 1, constant: 0)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        self.nameLabel.frame = self.bounds
//    }
    
    //MARK: - private property
    private lazy var nameLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(15)
        tempLabel.textColor = UIColor.grayColor()
        tempLabel.text = "购物篮"
        tempLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        return tempLabel
        }()
}
