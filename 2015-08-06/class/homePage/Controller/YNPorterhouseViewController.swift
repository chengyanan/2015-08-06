//
//  YNPorterhouseViewController.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/1.
//  Copyright (c) 2015年 农盟. All rights reserved.
// 店内菜品

import UIKit

class YNPorterhouseViewController: UIViewController , YNPorterhouseTopListViewDelegate{
    
    //MARK: - public proporty
    var restaurant: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = restaurant?.title
        self.view.backgroundColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1.0)
        
        self.view.addSubview(topListView)
        self.view.addSubview(indicator)
        self.view.addSubview(scrollView)
        
        addViewToScrollView()
        
        
    }
    
    //MARK: - custom method
    func addViewToScrollView() {
        
        for var i = 0; i < Int(self.page); ++i {
       
            var viewX = self.view.frame.size.width * CGFloat(i)
            
//            if i != 0 {
//                
//                viewX += self.space
//            }
            
            var view: UIView = UIView(frame: CGRectMake(viewX, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height))
            
            var titleLabel: UILabel = UILabel(frame: CGRectMake(0, 0, 50, 50))
            titleLabel.backgroundColor = UIColor.greenColor()
            titleLabel.text = "hello rose"
            
            view.addSubview(titleLabel)
            view.backgroundColor = UIColor(red: 207/255.0, green: 207/255.0, blue: 207/255.0, alpha: 1.0)
            self.scrollView.addSubview(view)
        }
        
    }
    
    //MARK: - YNPorterhouseTopListViewDelegate
    func topListViewButtonTapped(button: UIButton) {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.indicator.frame = CGRectMake(button.frame.origin.x, self.topListY + self.topListHeight, button.frame.size.width, self.kIndicatorHeight)
            
        })
        
        
    }
    
    //MARK: - private proporty
    private let topListHeight: CGFloat = 44
    private let topListY: CGFloat = 64
    private let kIndicatorHeight: CGFloat = 2
    private let page: CGFloat = 3
    private let space: CGFloat = 15
    private lazy var indicator: UIView = {
        
        var tempView = UIView(frame: CGRectMake(0, self.topListY + self.topListHeight, self.view.frame.size.width/self.page, self.kIndicatorHeight))
        tempView.backgroundColor = kStyleColor
        return tempView
        
        }()
    
    private lazy var topListView: YNPorterhouseTopListView = {
        
        var temp = YNPorterhouseTopListView(frame: CGRectMake(0, self.topListY, self.view.frame.size.width, self.topListHeight))
        temp.delegate = self
        return temp
        
        }()
    
    private lazy var scrollView:UIScrollView = {
        
        var temp = UIScrollView(frame: CGRectMake(0, CGRectGetMaxY(self.indicator.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.indicator.frame)))
        temp.pagingEnabled = true
        temp.directionalLockEnabled = true
        
        let tempPage: Int = Int(self.page)
//        let contentWidth = self.view.frame.size.width * CGFloat(tempPage) + CGFloat(tempPage - 1) * self.space
        let contentWidth = self.view.frame.size.width * CGFloat(tempPage)
        temp.contentSize = CGSizeMake(contentWidth, 0)
        
//        temp.backgroundColor = UIColor(red: 207/255.0, green: 207/255.0, blue: 207/255.0, alpha: 1.0)
        return temp
        
        }()
}
