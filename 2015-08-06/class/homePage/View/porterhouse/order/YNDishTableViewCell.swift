//
//  YNDishTableViewCell.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/6.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

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


protocol YNDishTableViewCellDelegate {
    
    func dishTableViewCellAddButtonDidClick(_ cell: YNDishTableViewCell, button: UIButton)
    func dishTableViewCellMinusButtonDidClick(_ cell: YNDishTableViewCell)
}

class YNDishTableViewCell: UITableViewCell {

    //MARK: - public property
    var data: YNPorterhouseDish? {
   
        didSet {
       
            if let _ = data {
            
                self.setData()
                
            }
        }
    }
    
    var delegate: YNDishTableViewCellDelegate?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        self.setupInterface()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - private method
    
    
    func setData() {
        
        
        if let tempImageURL = data!.imageURL {
            
            let length = tempImageURL.lengthOfBytes(using: String.Encoding.utf8)
            
            if length > 0 {
                
                setImage()
                
            } else {
           
                self.iconImageView.image = UIImage(named: "image")
            }
        }


        self.nameLabel.text = data!.name
        
        let tempMonthSales = Int(data!.monthSales!)
        self.monthSalesLabel.text = "月售 \(tempMonthSales)"
        
        if let tempPrice = data!.price {
       
            self.priceLabel.text = "¥\(tempPrice)"
        } else {
       
            self.priceLabel.text = "暂未定价"
        }
        
        self.caloriesLabel.text = "热量:\(Int(data!.calories!))千焦"
        
        
        if data?.number > 0 {
            
            self.selectedNumberLabel.text = "\(data!.number)"
            self.selectedNumberLabel.isHidden = false
            self.minusButton.isHidden = false
            
        } else {
       
//            self.selectedNumberLabel.text = ""
            selectedNumberLabel.isHidden = true
            self.minusButton.isHidden = true
        }
        
    }
    
    
    func setImage() {
        
        if let tempImageURL = data!.imageURL {
            
            let url: URL? = URL(string: tempImageURL)
            
            if let tempUrl = url {
                
                
                
                
                DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                    
                    
                    let imageData: Data? = try? Data(contentsOf: tempUrl)
                    
                    if let tempData = imageData {
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            self.iconImageView.image = UIImage(data: tempData)
                        })
                        
                    }
                    
                    
                }
                
                
                
  //ios10换成了上面的方法
                
//                DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: { () -> Void in
//                    
//                    let imageData: Data? = try? Data(contentsOf: tempUrl)
//                    
//                    if let tempData = imageData {
//                        
//                        DispatchQueue.main.async(execute: { () -> Void in
//                            
//                            self.iconImageView.image = UIImage(data: tempData)
//                        })
//                        
//                    }
//                    
//                })
                
                
            } else {
                
                print("\n YNDishTableViewCell - 图片没有URL \n", terminator: "")
            }

            
        }
        
    }

    
    func setupInterface() {
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(monthSalesLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(addButton)
        self.contentView.addSubview(caloriesLabel)
        self.contentView.addSubview(selectedNumberLabel)
        self.contentView.addSubview(minusButton)
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(separatorView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupLayout()
        
    }
    
    func setupLayout() {
        
        //nameLabel
        Layout().addTopConstraint(nameLabel, toView: self.contentView, multiplier: 1, constant: 10)
        Layout().addRightConstraint(nameLabel, toView: self.contentView, multiplier: 1, constant: -10)
        Layout().addHeightConstraint(nameLabel, toView: nil, multiplier: 0, constant: 24)
        Layout().addLeftConstraint(nameLabel, toView: self.contentView, multiplier: 1, constant: 68)
        
        //monthSalesLabel
        Layout().addLeftConstraint(monthSalesLabel, toView: nameLabel, multiplier: 1, constant: 0)
        Layout().addTopToBottomConstraint(monthSalesLabel, toView: nameLabel, multiplier: 1, constant: 3)
        Layout().addHeightConstraint(monthSalesLabel, toView: nil, multiplier: 0, constant: 15)
        //Layout().addRightConstraint(monthSalesLabel, toView: nameLabel, multiplier: 1, constant: 0)
        
        //addButton
        Layout().addRightConstraint(addButton, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addTopToBottomConstraint(addButton, toView: monthSalesLabel, multiplier: 1, constant: -3.5)
        Layout().addWidthConstraint(addButton, toView: nil, multiplier: 0, constant: 44)
        Layout().addHeightConstraint(addButton, toView: nil, multiplier: 0, constant: 44)
        
        //priceLabel
        Layout().addLeftConstraint(priceLabel, toView: nameLabel, multiplier: 1, constant: 0)
        Layout().addTopConstraint(priceLabel, toView: addButton, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(priceLabel, toView: addButton, multiplier: 1, constant: 0)
        //Layout().addRightConstraint(priceLabel, toView: monthSalesLabel, multiplier: 1, constant: 0)
        
        //caloriesLabel
        Layout().addLeftConstraint(caloriesLabel, toView: nameLabel, multiplier: 1, constant: 0)
        Layout().addTopToBottomConstraint(caloriesLabel, toView: addButton, multiplier: 1, constant: -3.5)
        Layout().addBottomConstraint(caloriesLabel, toView: self.contentView, multiplier: 1, constant: -10)
        //Layout().addWidthConstraint(caloriesLabel, toView: self.contentView, multiplier: 1, constant: 0)
        
        //selectedNumberLabel
        Layout().addTopConstraint(selectedNumberLabel, toView: addButton, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(selectedNumberLabel, toView: addButton, multiplier: 1, constant: 0)
        
        Layout().addWidthConstraint(selectedNumberLabel, toView: nil, multiplier: 1, constant: 24)
        Layout().addRightToLeftConstraint(selectedNumberLabel, toView: addButton, multiplier: 1, constant: 8)
        
        //minusButton
        Layout().addWidthConstraint(minusButton, toView: addButton, multiplier: 1, constant: 0)
        Layout().addTopConstraint(minusButton, toView: addButton, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(minusButton, toView: addButton, multiplier: 1, constant: 0)
        Layout().addRightToLeftConstraint(minusButton, toView: selectedNumberLabel, multiplier: 1, constant: 8)
        
        //iconImageView
        Layout().addTopConstraint(iconImageView, toView: nameLabel, multiplier: 1, constant: 4)
        Layout().addLeftConstraint(iconImageView, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(iconImageView, toView: nil, multiplier: 0, constant: 60)
        Layout().addHeightConstraint(iconImageView, toView: nil, multiplier: 0, constant: 60)
        
        //separatorView
        Layout().addLeftConstraint(separatorView, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addRightConstraint(separatorView, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(separatorView, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addHeightConstraint(separatorView, toView: self.contentView, multiplier: 0, constant: 0.6)
    }

    
    //MARK: - event response
    func addButtonDidClick() {
        
        data!.number += 1
        
        selectedNumberLabel.text = "\(data!.number)"
        
        if data!.number > 0 {
       
            self.delegate?.dishTableViewCellAddButtonDidClick(self, button: self.addButton)
            
            selectedNumberLabel.isHidden = false
            minusButton.isHidden = false
            
        }
        
    }
    
    func minusButtonDidClick() {
        
        data!.number -= 1
        selectedNumberLabel.text = "\(data!.number)"
        
        self.delegate?.dishTableViewCellMinusButtonDidClick(self)
        
        if data!.number <= 0 {
            
            selectedNumberLabel.isHidden = true
            minusButton.isHidden = true
            
        }
        
    }
    
    //MARK: - private property
    fileprivate lazy var iconImageView: UIImageView = {
        
        var tempImageView = UIImageView()
        tempImageView.contentMode = UIViewContentMode.scaleToFill
        tempImageView.translatesAutoresizingMaskIntoConstraints = false
        tempImageView.translatesAutoresizingMaskIntoConstraints = false
        return tempImageView
        
        }()
    fileprivate lazy var nameLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 17)
        tempLabel.textColor = UIColor.black
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
        }()

    fileprivate lazy var monthSalesLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 12)
        tempLabel.textColor = UIColor.gray
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
        }()
    
    fileprivate lazy var priceLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 15)
        tempLabel.textColor = UIColor.black
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.textColor = kStyleColor
        tempLabel.textAlignment = NSTextAlignment.justified
        return tempLabel
        }()
    
    fileprivate lazy var caloriesLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        tempLabel.textColor = UIColor.black
        tempLabel.textColor = UIColor.gray
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
        }()
    
    fileprivate lazy var selectedNumberLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        tempLabel.textColor = UIColor.black
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return tempLabel
        }()
    
    fileprivate lazy var addButton: UIButton = {
        
        // 49 * 49
        var tempView = UIButton()
        tempView.setImage(UIImage(named: "food_icon_add"), for: UIControlState())
        
        tempView.translatesAutoresizingMaskIntoConstraints = false
        
        tempView.addTarget(self, action: #selector(YNDishTableViewCell.addButtonDidClick), for: UIControlEvents.touchUpInside)
        return tempView
        
        }()
    
    fileprivate lazy var minusButton: UIButton = {
        
        // 49 * 49
        var tempView = UIButton()
        tempView.setImage(UIImage(named: "food_icon_minus"), for: UIControlState())
        tempView.translatesAutoresizingMaskIntoConstraints = false
        tempView.addTarget(self, action: #selector(YNDishTableViewCell.minusButtonDidClick), for: UIControlEvents.touchUpInside)
        tempView.isHidden = true
        return tempView
        
        }()
    
    fileprivate lazy var separatorView: UIView = {
        
        var tempView = UIView()
        tempView.backgroundColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 223/255.0, alpha: 1)
        tempView.translatesAutoresizingMaskIntoConstraints = false
        return tempView
        }()

    
}
