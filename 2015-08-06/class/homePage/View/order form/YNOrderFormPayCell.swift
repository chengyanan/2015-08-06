//
//  YNOrderFormPayCell.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/18.
//  Copyright (c) 2015年 农盟. All rights reserved.
//付款cell

import UIKit


protocol YNOrderFormPayCellDelegate {
    
    func orderFormPayCellSelectedButtonDidClick(cell: YNOrderFormPayCell)
}


class YNOrderFormPayCell: UITableViewCell {

    //public proporty
    var delegate:YNOrderFormPayCellDelegate?
    var payWay: PayWay? {
        
        didSet {
       
            nameLabel.text = payWay?.name
            
            if payWay!.selected {
           
                paySelectedButton.selected = true
                
            } else {
           
                paySelectedButton.selected = false
            }
            
            if payWay?.discount > 0 {
           
                minusLabel.hidden = false
                minusLabel.text = "立减" + String(payWay!.discount)
            } else {
           
                minusLabel.hidden = true
            }
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
        self.contentView.addSubview(minusLabel)
        self.contentView.addSubview(paySelectedButton)
    }
    
    func setupLayout() {
    
        //nameLabel
        Layout().addLeftConstraint(nameLabel, toView: self.contentView, multiplier: 1, constant: 12)
        Layout().addTopBottomConstraints(nameLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(nameLabel, toView: nil, multiplier: 0, constant: 60)
        
        //minusLabel
        Layout().addLeftToRightConstraint(minusLabel, toView: nameLabel, multiplier: 1, constant: 10)
        Layout().addCenterYConstraint(minusLabel, toView: nameLabel, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(minusLabel, toView: nil, multiplier: 0, constant: 50)
        Layout().addHeightConstraint(minusLabel, toView: nil, multiplier: 0, constant: 20)
        
        //paySelectedButton
        Layout().addRightConstraint(paySelectedButton, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addTopBottomConstraints(paySelectedButton, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(paySelectedButton, toView: nil, multiplier: 0, constant: 60)
    
    }
    
    //MARK: - event response
    func paySelectedButtonDidClick() {
   
        if !paySelectedButton.selected {
       
            paySelectedButton.selected = !paySelectedButton.selected
            payWay?.selected = paySelectedButton.selected
            
            //通知代理
            delegate?.orderFormPayCellSelectedButtonDidClick(self)
        }
        
        
    }
    
    //MARK: - private proporty
    private lazy var nameLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(15)
        tempLabel.textColor = UIColor.blackColor()
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
//        tempLabel.text = "在线支付"
        return tempLabel
        }()
    
       private lazy var minusLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(13)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
//        tempLabel.text = "立减15"
        tempLabel.textColor = UIColor.whiteColor()
        tempLabel.backgroundColor = UIColor.redColor()
        tempLabel.layer.cornerRadius = 3
        tempLabel.clipsToBounds = true
        tempLabel.textAlignment = NSTextAlignment.Center
        tempLabel.hidden = true
        return tempLabel
        }()
    
    private lazy var paySelectedButton: UIButton = {
        
        var tempView = UIButton()
        tempView.setImage(UIImage(named: "icon_radio"), forState: UIControlState.Normal)
        tempView.setImage(UIImage(named: "icon_radio_on"), forState: UIControlState.Selected)
        tempView.translatesAutoresizingMaskIntoConstraints = false
        tempView.addTarget(self, action: "paySelectedButtonDidClick", forControlEvents: UIControlEvents.TouchUpInside)
        return tempView
        
        }()
    
}
