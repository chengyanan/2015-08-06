//
//  YNOrderFormSelectDishCell.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/18.
//  Copyright (c) 2015年 农盟. All rights reserved.
//点过的菜品cell

import UIKit

class YNOrderFormSelectDishCell: UITableViewCell {

    //MARK: - public proporty
    var data: YNPorterhouseDish? {
        
        didSet {
                
                self.setData()
            
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
    
    func setData() {
   
        self.nameLabel.text = data?.name
        self.selectedNumberLabel.text = "x\(data!.number)"
        self.priceLabel.text = "¥\(data!.price! * Float(data!.number))"
    }
    
    func setupInterface() {
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(selectedNumberLabel)
        self.contentView.addSubview(priceLabel)
        
    }
    func setupLayout() {
        
        //priceLabel
        Layout().addTopBottomConstraints(priceLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addRightConstraint(priceLabel, toView: self.contentView, multiplier: 1, constant: -10)
        Layout().addWidthConstraint(priceLabel, toView: nil, multiplier: 0, constant: 80)
        
        //selectedNumberLabel
        Layout().addTopBottomConstraints(selectedNumberLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addRightToLeftConstraint(selectedNumberLabel, toView: priceLabel, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(selectedNumberLabel, toView: nil, multiplier: 0, constant: 40)
        
        //nameLabel
        Layout().addTopBottomConstraints(nameLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addLeftConstraint(nameLabel, toView: self.contentView, multiplier: 1, constant: 12)
        Layout().addRightToLeftConstraint(nameLabel, toView: selectedNumberLabel, multiplier: 1, constant: -10)
    }
    
    //MARK: - private proporty
    private lazy var nameLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(15)
        tempLabel.textColor = UIColor.blackColor()
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
        }()
    
    private lazy var selectedNumberLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(15)
        tempLabel.textColor = UIColor.blackColor()
        tempLabel.textAlignment = NSTextAlignment.Right
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return tempLabel
        }()
    
    private lazy var priceLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(15)
        tempLabel.textColor = UIColor.blackColor()
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.textColor = kStyleColor
        tempLabel.textAlignment = NSTextAlignment.Right
        return tempLabel
        }()
    
    override func drawRect(rect: CGRect) {
        
        let rectY = self.bounds.size.height/2 - 2
        let cycleRect = CGRectMake(6, rectY, 4, 4)
        
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        
        CGContextSetRGBFillColor(context, 71/255.0, 185/255.0, 27/255.0, 1)
        
        CGContextAddEllipseInRect(context, cycleRect)
        
        CGContextDrawPath(context, CGPathDrawingMode.Fill)
    }
}
