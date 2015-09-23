//
//  YNOrderFormComponCell.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/18.
//  Copyright (c) 2015年 农盟. All rights reserved.
// 满减优惠cell

import UIKit

class YNOrderFormComponCell: UITableViewCell {

    
    //public proporty
    var discount: String? {
   
        didSet {
       
            priceLabel.text = discount
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        setupInterface()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private method
    func setupInterface() {
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(detailLabel)
        self.contentView.addSubview(priceLabel)
    }
    
    func setupLayout() {
        
        //nameLabel
        Layout().addLeftConstraint(nameLabel, toView: self.contentView, multiplier: 1, constant: 12)
        Layout().addTopBottomConstraints(nameLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(nameLabel, toView: nil, multiplier: 0, constant: 60)
        
        //detailLabel
        Layout().addLeftToRightConstraint(detailLabel, toView: nameLabel, multiplier: 1, constant: 10)
        Layout().addCenterYConstraint(detailLabel, toView: nameLabel, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(detailLabel, toView: nil, multiplier: 0, constant: 20)
        Layout().addHeightConstraint(detailLabel, toView: nil, multiplier: 0, constant: 20)
        
        //priceLabel
        Layout().addRightConstraint(priceLabel, toView: self.contentView, multiplier: 1, constant: -16)
        Layout().addTopBottomConstraints(priceLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(priceLabel, toView: nil, multiplier: 0, constant: 60)
        
    }

    
    //MARK: - private proporty
    private lazy var nameLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(15)
        tempLabel.textColor = UIColor.blackColor()
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.text = "满减优惠"
        return tempLabel
        }()
    
    private lazy var detailLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(13)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.text = "减"
        tempLabel.textColor = UIColor.whiteColor()
        tempLabel.textAlignment = NSTextAlignment.Center
        tempLabel.backgroundColor = UIColor(red: 251/255.0, green: 81/255.0, blue: 9/255.0, alpha: 1)
        tempLabel.layer.cornerRadius = 3
        tempLabel.clipsToBounds = true
        return tempLabel
        }()
    
    private lazy var priceLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(15)
        tempLabel.textColor = UIColor(red: 251/255.0, green: 81/255.0, blue: 9/255.0, alpha: 1)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
//        tempLabel.text = "-15"
        tempLabel.textAlignment = NSTextAlignment.Right
        return tempLabel
        }()
    
}
