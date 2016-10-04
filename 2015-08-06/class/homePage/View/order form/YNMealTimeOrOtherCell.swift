//
//  YNMealTimeOrOtherCell.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/18.
//  Copyright (c) 2015年 农盟. All rights reserved.
//备注cell

import UIKit

class YNMealTimeOrOtherCell: UITableViewCell {

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
        self.contentView.addSubview(indicatorImageView)
    
    }
    
    func setupLayout() {
   
        //nameLabel
        Layout().addLeftConstraint(nameLabel, toView: self.contentView, multiplier: 1, constant: 12)
        Layout().addTopBottomConstraints(nameLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(nameLabel, toView: nil, multiplier: 0, constant: 100)
        
        //indicatorImageView
        Layout().addRightConstraint(indicatorImageView, toView: self.contentView, multiplier: 1, constant: -20)
        Layout().addWidthConstraint(indicatorImageView, toView: nil, multiplier: 0, constant: 7)
        Layout().addHeightConstraint(indicatorImageView, toView: nil, multiplier: 0, constant: 12)
        Layout().addCenterYConstraint(indicatorImageView, toView: self.contentView, multiplier: 1, constant: 0)
        
        //detailLabel
        Layout().addRightToLeftConstraint(detailLabel, toView: indicatorImageView, multiplier: 1, constant: -10)
        Layout().addLeftToRightConstraint(detailLabel, toView: nameLabel, multiplier: 1, constant: 3)
        Layout().addTopBottomConstraints(detailLabel, toView: self.contentView, multiplier: 1, constant: 0)
    }
    
    //MARK: - private proporty
    fileprivate lazy var nameLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 15)
        tempLabel.textColor = UIColor.black
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.text = "备注"
        return tempLabel
        }()
    
    fileprivate lazy var detailLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.text = "添加备注"
        tempLabel.textColor = UIColor.black
        tempLabel.textAlignment = NSTextAlignment.right
        return tempLabel
        }()
    
    fileprivate lazy var indicatorImageView: UIImageView = {
        
        var tempView = UIImageView(image: UIImage(named: "icon_cell_rightArrow")!)
        tempView.contentMode = UIViewContentMode.scaleAspectFit
        tempView.translatesAutoresizingMaskIntoConstraints = false
        return tempView
        }()
}
