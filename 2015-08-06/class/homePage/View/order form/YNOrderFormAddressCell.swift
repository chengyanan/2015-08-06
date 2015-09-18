//
//  YNOrderFormAddressCell.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/17.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

class YNOrderFormAddressCell: UITableViewCell {

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        setupInterface()
        setupLayout()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
   
        //topImageView
        Layout().addTopConstraint(topImageView, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addLeftConstraint(topImageView, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addRightConstraint(topImageView, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addHeightConstraint(topImageView, toView: nil, multiplier: 0, constant: 2)
        
        //userNameLabel
        Layout().addLeftConstraint(userNameLabel, toView: self.contentView, multiplier: 1, constant: 12)
        Layout().addTopToBottomConstraint(userNameLabel, toView: topImageView, multiplier: 1, constant: 8)
        Layout().addWidthConstraint(userNameLabel, toView: nil, multiplier: 0, constant: 50)
        Layout().addHeightConstraint(userNameLabel, toView: nil, multiplier: 0, constant: 20)
        
        //userGenderLabel
        Layout().addLeftToRightConstraint(userGenderLabel, toView: userNameLabel, multiplier: 1, constant: 0)
        Layout().addTopBottomConstraints(userGenderLabel, toView: userNameLabel, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(userGenderLabel, toView: nil, multiplier: 0, constant: 40)
        
        //userPhoneNumberLabel
        Layout().addTopBottomConstraints(userPhoneNumberLabel, toView: userNameLabel, multiplier: 1, constant: 0)
        Layout().addLeftToRightConstraint(userPhoneNumberLabel, toView: userGenderLabel, multiplier: 1, constant: 30)
        Layout().addRightConstraint(userPhoneNumberLabel, toView: self.contentView, multiplier: 1, constant: 0)
        
        
        //indicatorImageView
        Layout().addRightConstraint(indicatorImageView, toView: self.contentView, multiplier: 1, constant: -20)
        Layout().addWidthConstraint(indicatorImageView, toView: nil, multiplier: 0, constant: 7)
        Layout().addHeightConstraint(indicatorImageView, toView: nil, multiplier: 0, constant: 12)
        Layout().addCenterYConstraint(indicatorImageView, toView: self.contentView, multiplier: 1, constant: 0)
        
        //userAddressLabel
        Layout().addLeftConstraint(userAddressLabel, toView: userNameLabel, multiplier: 1, constant: 0)
        Layout().addRightToLeftConstraint(userAddressLabel, toView: indicatorImageView, multiplier: 1, constant: -12)
        Layout().addTopToBottomConstraint(userAddressLabel, toView: userNameLabel, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(userAddressLabel, toView: self.contentView, multiplier: 1, constant: -8)
        
        //bottomImageView
        Layout().addBottomConstraint(bottomImageView, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addLeftConstraint(bottomImageView, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addRightConstraint(bottomImageView, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addHeightConstraint(bottomImageView, toView: nil, multiplier: 0, constant: 2)
        
        
    }
    
    func setupInterface() {
   
        self.contentView.addSubview(userNameLabel)
        self.contentView.addSubview(userGenderLabel)
        self.contentView.addSubview(userPhoneNumberLabel)
        self.contentView.addSubview(userAddressLabel)
        self.contentView.addSubview(topImageView)
        self.contentView.addSubview(bottomImageView)
        self.contentView.addSubview(indicatorImageView)
    }
    
    private lazy var userNameLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(14)
        tempLabel.textColor = UIColor.blackColor()
        tempLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        tempLabel.text = "程亚男"
        return tempLabel
        }()
    
    private lazy var userGenderLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(14)
        tempLabel.textColor = UIColor.blackColor()
        tempLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        tempLabel.text = "女士"
        return tempLabel
        }()
    
    private lazy var userPhoneNumberLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(14)
        tempLabel.textColor = UIColor.blackColor()
        tempLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        tempLabel.text = "18790295312"
        return tempLabel
        }()
    private lazy var userAddressLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(14)
        tempLabel.textColor = UIColor.blackColor()
        tempLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        tempLabel.text = "古德佳苑7号楼2单元35室"
        tempLabel.numberOfLines = 2
        return tempLabel
        }()
    
    private lazy var topImageView: UIImageView = {
        
        var tempView = UIImageView()
        tempView.backgroundColor = UIColor(patternImage: UIImage(named: "address_line_bg")!)
        tempView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return tempView
        }()
    private lazy var bottomImageView: UIImageView = {
        
        var tempView = UIImageView()
        tempView.backgroundColor = UIColor(patternImage: UIImage(named: "address_line_bg")!)
        tempView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return tempView
        }()
    private lazy var indicatorImageView: UIImageView = {
        
        var tempView = UIImageView(image: UIImage(named: "icon_cell_rightArrow")!)
        tempView.contentMode = UIViewContentMode.ScaleAspectFit
        tempView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return tempView
        }()
}
