//
//  YNVertifyOrderTableViewCell.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/28.
//  Copyright © 2015年 农盟. All rights reserved.
//

import UIKit

class YNVertifyOrderTableViewCell: UITableViewCell {

    //MARK: - public proporty
    var totalPrice: Float? {
    
        didSet {
        
            self.priceLabel.text = "¥\(totalPrice!)"
        
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
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(priceLabel)
    }
    func setupLayout() {
        //nameLabel
        Layout().addLeftTopBottomConstraints(nameLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(nameLabel, toView: nil, multiplier: 0, constant: 100)
        
        //priceLabel
        Layout().addRightTopBottomConstraints(priceLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(priceLabel, toView: nil, multiplier: 0, constant: 100)
        
    }
   
//MARK: - private UI
    
    private lazy var nameLabel: UILabel = {
        
        var tempLabel = UILabel()
//        tempLabel.font = UIFont.systemFontOfSize(14)
        tempLabel.textAlignment = NSTextAlignment.Center
        tempLabel.textColor = UIColor.blackColor()
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.text = "订单金额"
        return tempLabel
        
        }()
    
    private lazy var priceLabel: UILabel = {
        
        var tempLabel = UILabel()
//        tempLabel.font = UIFont.systemFontOfSize(14)
        tempLabel.textColor = kStyleColor
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.text = "0"
        tempLabel.textAlignment = NSTextAlignment.Center
        return tempLabel
        
        }()


}
