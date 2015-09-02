//
//  YNPorterhouseTopListView.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/2.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

@objc protocol YNPorterhouseTopListViewDelegate: NSObjectProtocol {
    
     optional func topListViewButtonTapped(button: UIButton)
}

class YNPorterhouseTopListView: UIView {
    
   //MARK: - public proporty
    
    var delegate: YNPorterhouseTopListViewDelegate?
    
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

        for var i = 0; i < buttonArray.count; ++i {
       
            let x: CGFloat = width * CGFloat(i)
            buttonArray[i].frame = CGRectMake(x, 0, width, height)
        }
        
        indicator.frame = CGRectMake(0, height, width, 2)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private proporty
    private let kIndicatorHeight: CGFloat = 2
    private lazy var buttonArray: Array<UIButton> = {
        
        return Array()
        }()
    
    private lazy var commodityButon: UIButton = {
        
        var button = self.buttonWithTitle("点菜")
        button.selected = true
        return button

        }()
    private lazy var appraisalButon: UIButton = {
    
        return self.buttonWithTitle("评价")
        }()
    
    private lazy var businessButon: UIButton = {

        return self.buttonWithTitle("商家")
       }()
    
    private lazy var indicator: UIView = {
        
        var tempView = UIView()
        tempView.backgroundColor = kStyleColor
        return tempView
        }()

    //MARK: - private method 
    func buttonWithTitle(title: String)->UIButton {
        
        var button: UIButton = UIButton()
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.setTitleColor(kStyleColor, forState: UIControlState.Selected)
        button.setTitleColor(kStyleColor, forState: UIControlState.Highlighted)
        button.addTarget(self, action: "buttonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
    }
    
    func buttonTapped(button: UIButton) {
   
        if !button.selected {
            
            button.selected = true
            
            for item in self.buttonArray {
           
                if !(item == button) {
               
                    item.selected = false
                }
            }
            
            if let tempDelegaye:YNPorterhouseTopListViewDelegate = self.delegate {
           
                if tempDelegaye.respondsToSelector("topListViewButtonTapped:") {
               
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
