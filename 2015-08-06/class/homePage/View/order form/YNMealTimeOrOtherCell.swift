//
//  YNMealTimeOrOtherCell.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/18.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

class YNMealTimeOrOtherCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        setupInterface()
        setupLayout()
    }

    required init(coder aDecoder: NSCoder) {
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
    private lazy var nameLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(15)
        tempLabel.textColor = UIColor.blackColor()
        tempLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        tempLabel.text = "用餐时间"
        return tempLabel
        }()
    
    private lazy var detailLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(13)
        tempLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        tempLabel.text = "选择时间"
        tempLabel.textColor = UIColor.blackColor()
        tempLabel.textAlignment = NSTextAlignment.Right
        return tempLabel
        }()
    
    private lazy var indicatorImageView: UIImageView = {
        
        var tempView = UIImageView(image: UIImage(named: "icon_cell_rightArrow")!)
        tempView.contentMode = UIViewContentMode.ScaleAspectFit
        tempView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return tempView
        }()
}
