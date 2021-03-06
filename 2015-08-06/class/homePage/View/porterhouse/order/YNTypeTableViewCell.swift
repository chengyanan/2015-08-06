//
//  YNTypeTableViewCell.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/6.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

class YNTypeTableViewCell: UITableViewCell {

    //MARK: - public property
    var data: YNPorthouseType? {
   
        didSet {
       
            if let _ = data {
           
                self.setData()
            }
            
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
         self.setupInterface()
    }

    func setData() {
        
        self.typeLabel.text = data!.title
        
        if data!.selected {
            
            self.backgroundColor = UIColor.white
            self.indictorView.isHidden = false
            self.typeLabel.textColor = kStyleColor
            
        } else {
            
            self.backgroundColor = UIColor.clear
            self.indictorView.isHidden = true
            
            self.typeLabel.textColor = UIColor.black
        }
        

        if data!.selectedNumber > 0 {
       
            self.numberLabel.text = "\(data!.selectedNumber)"
            
            self.numberLabel.isHidden = false

            
        } else {
       
            self.numberLabel.isHidden = true
        }
        
    }
    
    func setupInterface() {
   
        self.contentView.addSubview(typeLabel)
        self.contentView.addSubview(indictorView)
        self.contentView.addSubview(numberLabel)
        self.contentView.addSubview(separatorView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private property
    fileprivate lazy var iconImageView: UIImageView = {
        
        var tempImageView = UIImageView()
        tempImageView.contentMode = UIViewContentMode.scaleToFill
        tempImageView.translatesAutoresizingMaskIntoConstraints = false
        return tempImageView
        
        }()
    
    fileprivate lazy var typeLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 14)
        tempLabel.textColor = UIColor(red: 76/255.0, green: 76/255.0, blue: 76/255.0, alpha: 1)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.textAlignment = NSTextAlignment.left
        return tempLabel
        }()
    
    fileprivate lazy var numberLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 10)
        tempLabel.textColor = UIColor.white
        tempLabel.backgroundColor = kStyleColor
        tempLabel.sizeToFit()
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.layer.cornerRadius = 3
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.clipsToBounds = true
        tempLabel.adjustsFontSizeToFitWidth = true
        
        return tempLabel
        
        }()

    fileprivate lazy var indictorView: UIView = {
   
        var tempView = UIView()
        tempView.backgroundColor = kStyleColor
        tempView.isHidden = true
        tempView.translatesAutoresizingMaskIntoConstraints = false
        return tempView
    }()
    
    fileprivate lazy var separatorView: UIView = {
        
        var tempView = UIView()
        tempView.backgroundColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 223/255.0, alpha: 1)
        tempView.translatesAutoresizingMaskIntoConstraints = false
        return tempView
        }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //indictorView
        Layout().addLeftConstraint(indictorView, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addTopConstraint(indictorView, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(indictorView, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(indictorView, toView: nil, multiplier: 1, constant: 2)
        
        //typeLabel
        Layout().addLeftToRightConstraint(typeLabel, toView: indictorView, multiplier: 1, constant: 6)
        Layout().addTopConstraint(typeLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(typeLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addRightConstraint(typeLabel, toView: self.contentView, multiplier: 1, constant: -3)
        
        //numberLabel
        Layout().addTopConstraint(numberLabel, toView: self.contentView, multiplier: 1, constant: 3)
        Layout().addRightConstraint(numberLabel, toView: self.contentView, multiplier: 1, constant: -2)
        
        Layout().addWidthConstraint(numberLabel, toView: nil, multiplier: 0, constant: 16)
        Layout().addHeightConstraint(numberLabel, toView: nil, multiplier: 0, constant: 15)
        
        
        Layout().addLeftConstraint(separatorView, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addRightConstraint(separatorView, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(separatorView, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addHeightConstraint(separatorView, toView: nil, multiplier: 0, constant: 1)

    }
    
    
}
