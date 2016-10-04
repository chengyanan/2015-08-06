//
//  YNHomePageViewController.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/6.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit
import CoreLocation

class YNHomePageViewController: UIViewController {
    
    fileprivate let kTopHight: CGFloat = kScreenHeight * 0.264
    fileprivate let kAverageHeight: CGFloat = kScreenHeight * 0.185
    fileprivate let kVerticalSpace: CGFloat = 3
    fileprivate let kHorizontalSpace: CGFloat = 2
    fileprivate let kLeftPercent: CGFloat = 0.6
    
    fileprivate var kLeftWith: CGFloat   {
        get {
       
            return (kScreenWidth-kHorizontalSpace) * kLeftPercent
        }
        
        }
    fileprivate var kRightWith: CGFloat {
   
        get {
       
            return kScreenWidth - kLeftWith
        }
    }
    
    fileprivate lazy var scrollView: UIScrollView = {
        
        var tempScrollView = UIScrollView(frame: self.view.bounds)
        tempScrollView.showsVerticalScrollIndicator = false
        tempScrollView.isDirectionalLockEnabled = true
        return tempScrollView
        
        }()
    
    fileprivate lazy var cycleViewDataArray: Array<UIImage> = {
       
            let image1:UIImage = UIImage(named: "img_01")!
            let image2:UIImage = UIImage(named: "img_02")!
            let image3:UIImage = UIImage(named: "img_03")!
            return [image1, image2, image3]
        
    }()
    
    fileprivate lazy var cycleView: YNCycleView = {
        
        var tempView: YNCycleView = YNCycleView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: self.kTopHight))
        tempView.dataArray = self.cycleViewDataArray
        return tempView
        
        }()
    
    fileprivate lazy var orderOrReserveButton: UIButton = {
        
        return self.buttonWithNormolImage("home_orderOrReserve", title: nil, action: #selector(YNHomePageViewController.orderOrReserveButtonHasClicked))
        
        }()
    
    fileprivate lazy var takeOutButton: UIButton = {
        
        return self.buttonWithNormolImage("home_takeOutButton", title: nil, action: #selector(YNHomePageViewController.takeOutButtonHasClicked))
        
        }()
    fileprivate lazy var promotionButton: UIButton = {
        
        return self.buttonWithNormolImage(nil, title: "优惠活动", action: #selector(YNHomePageViewController.promotionButtonHasClicked))

        }()
    
    fileprivate lazy var excursionsButton: UIButton = {
        
        return self.buttonWithNormolImage(nil, title: "郊游", action: #selector(YNHomePageViewController.excursionsButtonHasClicked))
        
        }()
    
    fileprivate lazy var privateCustomButton: UIButton = {
        //私人定制
        return self.buttonWithNormolImage(nil, title: "私人定制", action: #selector(YNHomePageViewController.privateCustomButtonHasClicked))
        
        }()
    
    fileprivate lazy var farmButton: UIButton = {
        
        return self.buttonWithNormolImage(nil, title: "农场", action: #selector(YNHomePageViewController.farmButtonHasClicked))
        
        }()
    fileprivate lazy var location: Location = {
        
        return Location()
        
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //开启定位
        location.startLocation()
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(cycleView)
        scrollView.addSubview(orderOrReserveButton)
        scrollView.addSubview(takeOutButton)
        scrollView.addSubview(promotionButton)
        scrollView.addSubview(excursionsButton)
        scrollView.addSubview(privateCustomButton)
        scrollView.addSubview(farmButton)
    
        setLayout()

    }
    
    func setLayout() {
   
        let orderOrReserveButtonConstraintH = NSLayoutConstraint.constraints(withVisualFormat: "H:|[orderOrReserveButton(kLeftWith)]", options: NSLayoutFormatOptions.directionLeftToRight, metrics: ["kLeftWith": kLeftWith], views: ["orderOrReserveButton": self.orderOrReserveButton])
        let orderOrReserveButtonConstraintV = NSLayoutConstraint.constraints(withVisualFormat: "V:[cycleView]-kVerticalSpace-[orderOrReserveButton(kAverageHeight)]", options: NSLayoutFormatOptions.directionLeftToRight, metrics: ["kVerticalSpace": self.kVerticalSpace, "kAverageHeight": self.kAverageHeight], views: ["orderOrReserveButton": self.orderOrReserveButton, "cycleView": self.cycleView])
        
        self.scrollView.addConstraints(orderOrReserveButtonConstraintH)
        self.scrollView.addConstraints(orderOrReserveButtonConstraintV)
        
        let takeOutButtonConstraintH = NSLayoutConstraint.constraints(withVisualFormat: "H:[orderOrReserveButton]-kHorizontalSpace-[takeOutButton(kRightWith)]", options: NSLayoutFormatOptions.directionLeftToRight, metrics: ["kHorizontalSpace": self.kHorizontalSpace, "kRightWith": self.kRightWith], views: ["orderOrReserveButton": self.orderOrReserveButton, "takeOutButton": self.takeOutButton])
        let takeOutButtonConstraintV = NSLayoutConstraint.constraints(withVisualFormat: "V:[cycleView]-kVerticalSpace-[takeOutButton(kAverageHeight)]", options: NSLayoutFormatOptions.directionLeftToRight, metrics: ["kVerticalSpace": self.kVerticalSpace, "kAverageHeight": self.kAverageHeight], views: ["cycleView": self.cycleView, "takeOutButton": self.takeOutButton])
        
        self.scrollView.addConstraints(takeOutButtonConstraintH)
        self.scrollView.addConstraints(takeOutButtonConstraintV)
        
        let promotionButtonConstraintH = NSLayoutConstraint.constraints(withVisualFormat: "H:|[promotionButton(kLeftWith)]", options: NSLayoutFormatOptions.directionLeftToRight, metrics: ["kLeftWith": kLeftWith], views: ["promotionButton": self.promotionButton])
        let promotionButtonConstraintV = NSLayoutConstraint.constraints(withVisualFormat: "V:[orderOrReserveButton]-kVerticalSpace-[promotionButton(kAverageHeight)]", options: NSLayoutFormatOptions.directionLeftToRight, metrics: ["kVerticalSpace": self.kVerticalSpace, "kAverageHeight": self.kAverageHeight], views: ["orderOrReserveButton": self.orderOrReserveButton, "promotionButton": self.promotionButton])
        
        self.scrollView.addConstraints(promotionButtonConstraintH)
        self.scrollView.addConstraints(promotionButtonConstraintV)
        
        let excursionsButtonConstraintH = NSLayoutConstraint.constraints(withVisualFormat: "H:[promotionButton]-kHorizontalSpace-[excursionsButton(kRightWith)]", options: NSLayoutFormatOptions.directionLeftToRight, metrics: ["kHorizontalSpace": self.kHorizontalSpace, "kRightWith": self.kRightWith], views: ["promotionButton": self.promotionButton, "excursionsButton": self.excursionsButton])
        let excursionsButtonConstraintV = NSLayoutConstraint.constraints(withVisualFormat: "V:[takeOutButton]-kVerticalSpace-[excursionsButton(kAverageHeight)]", options: NSLayoutFormatOptions.directionLeftToRight, metrics: ["kVerticalSpace": self.kVerticalSpace, "kAverageHeight": self.kAverageHeight], views: ["takeOutButton": self.takeOutButton, "excursionsButton": self.excursionsButton])
        
        self.scrollView.addConstraints(excursionsButtonConstraintH)
        self.scrollView.addConstraints(excursionsButtonConstraintV)
        
        let privateCustomButtonConstraintH = NSLayoutConstraint.constraints(withVisualFormat: "H:|[privateCustomButton(kLeftWith)]", options: NSLayoutFormatOptions.directionLeftToRight, metrics: ["kLeftWith": kLeftWith], views: ["privateCustomButton": self.privateCustomButton])
        let privateCustomButtonConstraintV = NSLayoutConstraint.constraints(withVisualFormat: "V:[promotionButton]-kVerticalSpace-[privateCustomButton(kAverageHeight)]", options: NSLayoutFormatOptions.directionLeftToRight, metrics: ["kVerticalSpace": self.kVerticalSpace, "kAverageHeight": self.kAverageHeight], views: ["promotionButton": self.promotionButton, "privateCustomButton": self.privateCustomButton])
        self.scrollView.addConstraints(privateCustomButtonConstraintH)
        self.scrollView.addConstraints(privateCustomButtonConstraintV)
        
        
        let farmButtonConstraintH = NSLayoutConstraint.constraints(withVisualFormat: "H:[privateCustomButton]-kHorizontalSpace-[farmButton(kRightWith)]", options: NSLayoutFormatOptions.directionLeftToRight, metrics: ["kHorizontalSpace": self.kHorizontalSpace, "kRightWith": self.kRightWith], views: ["privateCustomButton": self.privateCustomButton, "farmButton": self.farmButton])
        let farmButtonConstraintV = NSLayoutConstraint.constraints(withVisualFormat: "V:[excursionsButton]-kVerticalSpace-[farmButton(kAverageHeight)]", options: NSLayoutFormatOptions.directionLeftToRight, metrics: ["kVerticalSpace": self.kVerticalSpace, "kAverageHeight": self.kAverageHeight], views: ["excursionsButton": self.excursionsButton, "farmButton": self.farmButton])
        
        let farmButtonConstraintBottom = NSLayoutConstraint(item: farmButton, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
        
        self.scrollView.addConstraints(farmButtonConstraintH)
        self.scrollView.addConstraints(farmButtonConstraintV)
        self.scrollView.addConstraint(farmButtonConstraintBottom)
        
    }
    
    //MARK: - event responsor
    func orderOrReserveButtonHasClicked() {
   
        let orderVc: YNOrderViewController = YNOrderViewController()
        orderVc.hidesBottomBarWhenPushed = true
        
//        if let temp = self.location.cooridate {
//       
//            orderVc.cooridate = temp
//            
//        } else {
//            
//            print("\n没有定位到位置 \n", terminator: "")
//            
//            //***********************
//            
//            orderVc.cooridate = CLLocationCoordinate2DMake(34.784015750987791, 113.71269062975868)
//            //***********************
//        }
        
        
        orderVc.cooridate = CLLocationCoordinate2DMake(34.784015750987791, 113.71269062975868)
        
        self.navigationController?.pushViewController(orderVc, animated: true)
    }
    func takeOutButtonHasClicked() {
   
        
    }
    func promotionButtonHasClicked() {
   
        
    }
    
    func excursionsButtonHasClicked() {
   
        
    }
    
    func privateCustomButtonHasClicked() {
   
        
    }
    
    func farmButtonHasClicked() {
   
        
    }
    //MARK: - custom method
    func buttonWithNormolImage(_ imageName: String?,title: String?, action: Selector) -> UIButton {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitleColor(UIColor.black, for: UIControlState())
        
        button.backgroundColor = UIColor.yellow
        
        if let tempImage = imageName {
       
            button.setBackgroundImage(UIImage(named: tempImage), for: UIControlState())
        }
        
        if let tempTitle = title {
       
            button.setTitle(tempTitle, for: UIControlState())
        }
        
        button.addTarget(self, action: action, for: UIControlEvents.touchUpInside)
        return button
    }
}
