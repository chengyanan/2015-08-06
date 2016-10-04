//
//  YNOrderFormDeliveryCell.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/18.
//  Copyright (c) 2015年 农盟. All rights reserved.
//配送服务cell

import UIKit

class YNOrderFormDeliveryCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
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
        Layout().addWidthConstraint(nameLabel, toView: nil, multiplier: 0, constant: 60)
        Layout().addTopConstraint(nameLabel, toView: self.contentView, multiplier: 1, constant: 10)
        Layout().addHeightConstraint(nameLabel, toView: nil, multiplier: 0, constant: 20)
        
        //detailLabel
        Layout().addTopToBottomConstraint(detailLabel, toView: nameLabel, multiplier: 1, constant: 0)
         Layout().addBottomConstraint(detailLabel, toView: self.contentView, multiplier: 1, constant: -6)
        Layout().addLeftConstraint(detailLabel, toView: nameLabel, multiplier: 1, constant: 0)
       Layout().addRightConstraint(detailLabel, toView: self.contentView, multiplier: 1, constant: 0)
        
        //priceLabel
        Layout().addRightConstraint(priceLabel, toView: self.contentView, multiplier: 1, constant: -16)
        Layout().addTopBottomConstraints(priceLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(priceLabel, toView: nil, multiplier: 0, constant: 60)
        
    }
    
    
    //MARK: - private proporty
    fileprivate lazy var nameLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 15)
        tempLabel.textColor = UIColor.black
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.text = "配送费"
        return tempLabel
        }()
    
    fileprivate lazy var detailLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.text = "本订单由XXX提供配送服务"
        
        return tempLabel
        }()
    
    fileprivate lazy var priceLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 15)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.text = "¥0"
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.textColor = UIColor.gray
        return tempLabel
        }()
}
