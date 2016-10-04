//
//  YNOrderFormBottomView.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/23.
//  Copyright © 2015年 农盟. All rights reserved.
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


protocol YNOrderFormBottomViewDelegate {
    
    func orderFormBottomViewDoneButtonDidClick(_ orderFormBottomView: YNOrderFormBottomView)
}

class YNOrderFormBottomView: UIView {

    //public proporty
    
    var discount: Int? {
   
        didSet {
       
            if discount > 0 {
           
                discountLabel.isHidden = false
                discountLabel.text = "已优惠¥\(discount!)"
            } else {
            
                discountLabel.isHidden = true
                discountLabel.text = ""
                
            }
        }
    }
    
    var price: Float? {
        
        didSet {
       
            priceLabel.text = "共 ¥ \(Int(price!))"
        }
    }
    
    
    var delegate: YNOrderFormBottomViewDelegate?
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        setupInterface()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInterface() {
        
        self.addSubview(sepatator)
        self.addSubview(discountLabel)
        self.addSubview(priceLabel)
        self.addSubview(doneButton)
    }
    func setupLayout() {
        
        //sepatator
        Layout().addTopConstraint(sepatator, toView: self, multiplier: 1, constant: 0)
        Layout().addLeftConstraint(sepatator, toView: self, multiplier: 1, constant: 0)
        Layout().addRightConstraint(sepatator, toView: self, multiplier: 1, constant: 0)
        Layout().addHeightConstraint(sepatator, toView: nil, multiplier: 0, constant: 0.6)
        
        //discountLabel
        Layout().addTopToBottomConstraint(discountLabel, toView: sepatator, multiplier: 1, constant: 0)
        Layout().addLeftConstraint(discountLabel, toView: self, multiplier: 1, constant: 12)
        Layout().addBottomConstraint(discountLabel, toView: self, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(discountLabel, toView: nil, multiplier: 0, constant: 100)
        
        //doneButton
        Layout().addTopToBottomConstraint(doneButton, toView: sepatator, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(doneButton, toView: self, multiplier: 1, constant: 0)
        Layout().addRightConstraint(doneButton, toView: self, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(doneButton, toView: nil, multiplier: 0, constant: 120)
        
        //priceLabel
        Layout().addLeftToRightConstraint(priceLabel, toView: discountLabel, multiplier: 1, constant: 3)
        Layout().addRightToLeftConstraint(priceLabel, toView: doneButton, multiplier: 1, constant: -16)
        Layout().addTopToBottomConstraint(priceLabel, toView: sepatator, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(priceLabel, toView: self, multiplier: 1, constant: 0)
    }
    
    //MARK: - event response
    func doneButtonDidClick() {
        
        self.delegate?.orderFormBottomViewDoneButtonDidClick(self)
    }
    
    //MARK: - private proporty
    
    //灰色分割线
    fileprivate lazy var sepatator: UIView = {
        
        var tempView = UIView()
        tempView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        tempView.translatesAutoresizingMaskIntoConstraints = false
        return tempView
        }()
    
    //优惠
    fileprivate lazy var discountLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        tempLabel.textColor = UIColor(red: 251/255.0, green: 81/255.0, blue: 9/255.0, alpha: 1)
        tempLabel.isHidden = true
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
        }()
    
    //总价
    fileprivate lazy var priceLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.textColor = kStyleColor
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.textAlignment = NSTextAlignment.right
        return tempLabel
        }()

    fileprivate lazy var doneButton: UIButton = {
        
        var tempView: UIButton = UIButton()
        tempView.backgroundColor = kStyleColor
        tempView.setTitle("立即下单", for: UIControlState())
        tempView.addTarget(self, action: #selector(YNOrderFormBottomView.doneButtonDidClick), for: UIControlEvents.touchUpInside)
        tempView.translatesAutoresizingMaskIntoConstraints = false
        return tempView
        
        }()
    
}
