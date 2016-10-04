//
//  YNPorterhouseTopListView.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/2.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

@objc protocol YNPorterhouseTopListViewDelegate: NSObjectProtocol {
    
     @objc optional func topListViewButtonTapped(_ button: UIButton)
}

enum YNPorterhouseTopListSelected {
    
    case commodity
    case appraisal
    case business
}

class YNPorterhouseTopListView: UIView {
    
   //MARK: - public proporty
    
    var delegate: YNPorterhouseTopListViewDelegate?
    var currentSelected: YNPorterhouseTopListSelected? {
   
        didSet {
       
            if currentSelected == .commodity {
           
                self.appraisalButon.isSelected = false
                self.businessButon.isSelected = false
                self.commodityButon.isSelected = true
            }
            
            if currentSelected == .appraisal {
           
                self.businessButon.isSelected = false
                self.commodityButon.isSelected = false
                self.appraisalButon.isSelected = true
            }
            
            if currentSelected == .business {
           
                self.commodityButon.isSelected = false
                self.appraisalButon.isSelected = false
                self.businessButon.isSelected = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buttonArray.append(commodityButon)
        buttonArray.append(appraisalButon)
        buttonArray.append(businessButon)
        
        self.addSubview(commodityButon)
        self.addSubview(appraisalButon)
        self.addSubview(businessButon)
//        self.addSubview(indicator)
        
        let width: CGFloat = frame.size.width / CGFloat(buttonArray.count)
        let height: CGFloat = frame.size.height - kIndicatorHeight

        for i in 0 ..< buttonArray.count {
       
            let x: CGFloat = width * CGFloat(i)
            buttonArray[i].frame = CGRect(x: x, y: 0, width: width, height: height)
        }
        
        indicator.frame = CGRect(x: 0, y: height, width: width, height: 2)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private proporty
    fileprivate let kIndicatorHeight: CGFloat = 2
    fileprivate lazy var buttonArray: Array<UIButton> = {
        
        return Array()
        }()
    
    fileprivate lazy var commodityButon: UIButton = {
        
        var button = self.buttonWithTitle("点菜")
        button.tag = 0
        button.isSelected = true
        return button

        }()
    fileprivate lazy var appraisalButon: UIButton = {
    
        var button = self.buttonWithTitle("评价")
        button.tag = 1
        return button
        }()
    
    fileprivate lazy var businessButon: UIButton = {

        var button = self.buttonWithTitle("商家")
        button.tag = 2
        return button

       }()
    
    fileprivate lazy var indicator: UIView = {
        
        var tempView = UIView()
        tempView.backgroundColor = kStyleColor
        return tempView
        }()

    //MARK: - private method 
    func buttonWithTitle(_ title: String)->UIButton {
        
        let button: UIButton = UIButton()
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(UIColor.black, for: UIControlState())
        button.setTitleColor(kStyleColor, for: UIControlState.selected)
        button.setTitleColor(kStyleColor, for: UIControlState.highlighted)
        button.addTarget(self, action: #selector(YNPorterhouseTopListView.buttonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        return button
    }
    
    func buttonTapped(_ button: UIButton) {
   
        if !button.isSelected {
            
            button.isSelected = true
            
            for item in self.buttonArray {
           
                if !(item == button) {
               
                    item.isSelected = false
                }
            }
            
            if let tempDelegaye:YNPorterhouseTopListViewDelegate = self.delegate {
           
                if tempDelegaye.responds(to: #selector(YNPorterhouseTopListViewDelegate.topListViewButtonTapped(_:))) {
               
                    tempDelegaye.topListViewButtonTapped!(button)
                }
            }
            

            
//            UIView.animateWithDuration(0.3, animations: { () -> Void in
//                
//                self.indicator.frame = CGRectMake(button.frame.origin.x, button.frame.size.height, button.frame.size.width, self.kIndicatorHeight)
//                
//            })
            
        }
    }
    
}
