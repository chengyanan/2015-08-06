//
//  YNOrderTableCell.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/14.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

protocol YNOrderTableCellDelegate {
    
    func orderTableCellAddButtonDidClick(cell: YNOrderTableCell)
    func orderTableCellMinusButtonDidClick(cell: YNOrderTableCell)
}


class YNOrderTableCell: UITableViewCell {
    
    //MARK: - public property
    var data: YNPorterhouseDish? {
        
        didSet {
            
            if let tempData = data {
                
                self.setData()
                
            }
        }
    }

    var delegate:YNOrderTableCellDelegate?
    
    func setData() {
   
        let totalPrice = data!.price! * Float(data!.number)
        self.priceLabel.text = "¥\(totalPrice)"
        
        self.nameLabel.text = data!.name
       
        self.selectedNumberLabel.text = "\(data!.number)"
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        setupInterface()
        setupLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInterface() {
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(addButton)
        self.contentView.addSubview(selectedNumberLabel)
        self.contentView.addSubview(minusButton)
        
    }

    func setupLayout() {
        
        //addButton
        Layout().addRightConstraint(addButton, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addTopConstraint(addButton, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(addButton, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(addButton, toView: nil, multiplier: 0, constant: 44)
        
        //selectedNumberLabel
        Layout().addTopConstraint(selectedNumberLabel, toView: addButton, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(selectedNumberLabel, toView: addButton, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(selectedNumberLabel, toView: nil, multiplier: 0, constant: 24)
        Layout().addRightToLeftConstraint(selectedNumberLabel, toView: addButton, multiplier: 1, constant: 8)
        
        //minusButton
        Layout().addWidthConstraint(minusButton, toView: addButton, multiplier: 1, constant: 0)
        Layout().addTopConstraint(minusButton, toView: addButton, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(minusButton, toView: addButton, multiplier: 1, constant: 0)
        Layout().addRightToLeftConstraint(minusButton, toView: selectedNumberLabel, multiplier: 1, constant: 8)
        
        //priceLabel
        Layout().addTopConstraint(priceLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(priceLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(priceLabel, toView: nil, multiplier: 0, constant: 50)
        Layout().addRightToLeftConstraint(priceLabel, toView: minusButton, multiplier: 1, constant: -16)
        
//        //nameLabel
        Layout().addTopConstraint(nameLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(nameLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addLeftConstraint(nameLabel, toView: self.contentView, multiplier: 1, constant: 12)
        Layout().addRightToLeftConstraint(nameLabel, toView: priceLabel, multiplier: 1, constant: -10)
            
    }
    
    //MARK: - event response
    func addButtonDidClick() {
        
        ++data!.number
        
        selectedNumberLabel.text = "\(data!.number)"
        
        let totalPrice = data!.price! * Float(data!.number)
        self.priceLabel.text = "¥\(totalPrice)"
        
        self.delegate?.orderTableCellAddButtonDidClick(self)
        
    }
    
    func minusButtonDidClick() {
        
        --data!.number
        selectedNumberLabel.text = "\(data!.number)"
        
        let totalPrice = data!.price! * Float(data!.number)
        self.priceLabel.text = "¥\(totalPrice)"
        
        self.delegate?.orderTableCellMinusButtonDidClick(self)
        
    }

    
    
    //MARK: - private property
    private lazy var nameLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(17)
        tempLabel.textColor = UIColor.blackColor()
        tempLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        return tempLabel
        }()
    
    
    private lazy var priceLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(13)
        tempLabel.textColor = UIColor.blackColor()
        tempLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        tempLabel.textColor = kStyleColor
        tempLabel.textAlignment = NSTextAlignment.Justified
        return tempLabel
        }()
    
    private lazy var addButton: UIButton = {
        
        // 49 * 49
        var tempView = UIButton()
        tempView.setImage(UIImage(named: "food_icon_add"), forState: UIControlState.Normal)
        
        tempView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        tempView.addTarget(self, action: "addButtonDidClick", forControlEvents: UIControlEvents.TouchUpInside)
        return tempView
        
        }()
    
    private lazy var selectedNumberLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(13)
        tempLabel.textColor = UIColor.blackColor()
        tempLabel.textAlignment = NSTextAlignment.Center
        tempLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        return tempLabel
        }()
    
    private lazy var minusButton: UIButton = {
        
        // 49 * 49
        var tempView = UIButton()
        tempView.setImage(UIImage(named: "food_icon_minus"), forState: UIControlState.Normal)
        tempView.setTranslatesAutoresizingMaskIntoConstraints(false)
        tempView.addTarget(self, action: "minusButtonDidClick", forControlEvents: UIControlEvents.TouchUpInside)
        return tempView
        
        }()
}
