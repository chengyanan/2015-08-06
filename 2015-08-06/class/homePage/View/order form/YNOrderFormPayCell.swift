//
//  YNOrderFormPayCell.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/18.
//  Copyright (c) 2015年 农盟. All rights reserved.
//付款cell

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}



protocol YNOrderFormPayCellDelegate {
    
    func orderFormPayCellSelectedButtonDidClick(_ cell: YNOrderFormPayCell)
}


class YNOrderFormPayCell: UITableViewCell {

    //public proporty
    var delegate:YNOrderFormPayCellDelegate?
    var payWay: PayWay? {
        
        didSet {
       
            nameLabel.text = payWay?.name
            
            if payWay!.selected {
           
                paySelectedButton.isSelected = true
                
            } else {
           
                paySelectedButton.isSelected = false
            }
            
            if payWay?.discount > 0 {
           
                minusLabel.isHidden = false
                minusLabel.text = "立减" + String(payWay!.discount)
            } else {
           
                minusLabel.isHidden = true
            }
        }
        
    }
    
    
    
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
   
        if !paySelectedButton.isSelected {
       
            paySelectedButton.isSelected = !paySelectedButton.isSelected
            payWay?.selected = paySelectedButton.isSelected
            
            //通知代理
            delegate?.orderFormPayCellSelectedButtonDidClick(self)
        }
        
        
    }
    
    //MARK: - private proporty
    fileprivate lazy var nameLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 15)
        tempLabel.textColor = UIColor.black
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
//        tempLabel.text = "在线支付"
        return tempLabel
        }()
    
       fileprivate lazy var minusLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
//        tempLabel.text = "立减15"
        tempLabel.textColor = UIColor.white
        tempLabel.backgroundColor = UIColor.red
        tempLabel.layer.cornerRadius = 3
        tempLabel.clipsToBounds = true
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.isHidden = true
        return tempLabel
        }()
    
    fileprivate lazy var paySelectedButton: UIButton = {
        
        var tempView = UIButton()
        tempView.setImage(UIImage(named: "icon_radio"), for: UIControlState())
        tempView.setImage(UIImage(named: "icon_radio_on"), for: UIControlState.selected)
        tempView.translatesAutoresizingMaskIntoConstraints = false
        tempView.addTarget(self, action: #selector(YNOrderFormPayCell.paySelectedButtonDidClick), for: UIControlEvents.touchUpInside)
        return tempView
        
        }()
    
}
