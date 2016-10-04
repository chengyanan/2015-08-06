//
//  YNVertifyOrderPaymentTableViewCell.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/29.
//  Copyright © 2015年 农盟. All rights reserved.
//

import UIKit

protocol YNVertifyOrderPaymentTableViewCellDelegate {

    func vertifyOrderPaymentCellSelectedButtonDidClick(_ cell: YNVertifyOrderPaymentTableViewCell)

}

class YNVertifyOrderPaymentTableViewCell: UITableViewCell {

    //public proporty
    
    var delegate:YNVertifyOrderPaymentTableViewCellDelegate?
    
    var payWay: PayWay? {
    
        didSet {
        
            nameLabel.text = payWay?.name
            
            if payWay!.selected {
                
                paySelectedButton.isSelected = true
                
            } else {
                
                paySelectedButton.isSelected = false
            }
        
        }
    
    }

    var iamgeNmae: String? {
    
        didSet {
        
            self.iconImageView.image = UIImage(named: iamgeNmae!)
        
        }
    
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupInterface()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInterface() {
        
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(paySelectedButton)
    }
    
    func setupLayout() {
        
        //iconImageView
        Layout().addLeftConstraint(iconImageView, toView: self.contentView, multiplier: 1, constant: 12)
        Layout().addTopConstraint(iconImageView, toView: self.contentView, multiplier: 1, constant: 10)
        Layout().addBottomConstraint(iconImageView, toView: self.contentView, multiplier: 1, constant: -10)
        Layout().addWidthToHeightConstraints(iconImageView, toView: iconImageView, multiplier: 1, constant: 0)
        
        //nameLabel
        Layout().addLeftToRightConstraint(nameLabel, toView: iconImageView, multiplier: 1, constant: 3)
        Layout().addTopBottomConstraints(nameLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(nameLabel, toView: nil, multiplier: 0, constant: 100)
        
        //paySelectedButton
        Layout().addRightTopBottomConstraints(paySelectedButton, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addWidthToHeightConstraints(paySelectedButton, toView: paySelectedButton, multiplier: 1, constant: 0)
    }
    
    
    //MARK: - event response
    func paySelectedButtonDidClick() {
        
        if !paySelectedButton.isSelected {
            
            paySelectedButton.isSelected = !paySelectedButton.isSelected
            payWay?.selected = paySelectedButton.isSelected
            
            //通知代理
            
            self.delegate?.vertifyOrderPaymentCellSelectedButtonDidClick(self)
            
        }
        
    }
    
    //MARK: - private proporty
    fileprivate lazy var iconImageView: UIImageView = {
        
        var tempView = UIImageView()
        tempView.translatesAutoresizingMaskIntoConstraints = false
        return tempView
        
        }()
    
    fileprivate lazy var nameLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 15)
        tempLabel.textColor = UIColor.black
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
        }()
   
    fileprivate lazy var paySelectedButton: UIButton = {
        
        var tempView = UIButton()
        tempView.setImage(UIImage(named: "icon_radio"), for: UIControlState())
        tempView.setImage(UIImage(named: "icon_radio_on"), for: UIControlState.selected)
        tempView.translatesAutoresizingMaskIntoConstraints = false
        tempView.addTarget(self, action: #selector(YNVertifyOrderPaymentTableViewCell.paySelectedButtonDidClick), for: UIControlEvents.touchUpInside)
        return tempView
        
        }()
}
