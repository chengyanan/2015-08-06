//
//  YNPorterhouseViewController.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/1.
//  Copyright (c) 2015年 农盟. All rights reserved.
// 店内菜品

import UIKit

class YNPorterhouseViewController: UIViewController , YNPorterhouseTopListViewDelegate, UIScrollViewDelegate, YNPorterhouseOrderViewDelegate {
    
    //MARK: - public proporty
    var restaurant: Restaurant?
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 禁止使用系统自带的滑动手势
//        self.navigationController?.interactivePopGestureRecognizer!.enabled = false
        
        loaddata()
        
        self.title = restaurant?.title
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(topListView)
        self.view.addSubview(indicator)
        self.view.addSubview(scrollView)
        
        addViewToScrollView()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        let window = UIApplication.sharedApplication().keyWindow!
        
        
        for subview in window.subviews {
            
                if subview.tag == 100 {
                    
                    subview.removeFromSuperview()
                }
        }

    }
    
    //MARK: - data
    func loaddata() {
   
        let path = NSBundle.mainBundle().pathForResource("dishs", ofType: "plist")
        
        if let tempPath = path {
       
            let dataDict: NSDictionary = NSDictionary(contentsOfFile: tempPath)!
            
            if let status: Int = dataDict["status"] as? Int{
            
                if status == 1 {
               
                    let typeArray: NSArray = dataDict["data"] as! NSArray
                    
                    if typeArray.count > 0 {
                   
                        for var i = 0; i < typeArray.count; ++i {
                       
                            let type: YNPorthouseType = YNPorthouseType(dict: typeArray[i] as! NSDictionary)
                            
                            type.firstIndex = i
                            
                            if i == 0 {
                           
                               type.selected = true
                                
                            }
                            
                            self.typeArray.append(type)
                        }
                        
                        
                        
                        
                    } else {
                   
                        YNProgressHUD().showText("该商店暂未上传菜品", toView: self.view)
                    }
                }
            
            }
        
            
        } else {
       
            print("\n --plist文件不存在 --  \n", terminator: "")
        }
        
    }
    
    //MARK: - custom method
    func addViewToScrollView() {
        
        for var i = 0; i < Int(self.page); ++i {
       
            let viewX = self.scrollView.frame.size.width * CGFloat(i)
            
            let view: UIView = UIView()
            
            view.frame = CGRectMake(viewX, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
            
            var tempSubView: UIView?
            
            if i == 0 {
           
               let orderView = YNPorterhouseOrderView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.scrollView.frame.size.height))
                orderView.data = self.typeArray
                orderView.superViewTopViewHeight = self.topListHeight + self.kIndicatorHeight
                orderView.delegate = self
                
                view.addSubview(orderView)
                
            } else if i == 1 {
           
                tempSubView = YNPorterhouseValuationView()
                
            } else if i == 2 {
                
                tempSubView = YNPorterhouseDetailView()
            }
            
            tempSubView?.frame = CGRectMake(0, 0, self.view.frame.size.width, self.scrollView.frame.size.height)
            
            if let item = tempSubView {
           
                view.addSubview(item)
            }
        
            self.scrollView.addSubview(view)
        }
        
    }
    
    //MAEK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let x = scrollView.contentOffset.x / 3
        
        self.indicator.frame = CGRectMake(x, self.indicatorY, self.indicatorWidth, self.kIndicatorHeight)
        
        let tempPage = scrollView.contentOffset.x / scrollView.frame.size.width
        
        if  tempPage == 0 {
       
            self.topListView.currentSelected = YNPorterhouseTopListSelected.Commodity
            
        } else if tempPage == 1 {
            
            self.topListView.currentSelected = YNPorterhouseTopListSelected.Appraisal
            
        } else if tempPage == 2 {
            
            self.topListView.currentSelected = YNPorterhouseTopListSelected.Business
        }
        
    }
    
    //MARK: - YNPorterhouseTopListViewDelegate
    func topListViewButtonTapped(button: UIButton) {
        
        let scrollViewOffsetX = self.scrollView.frame.size.width * CGFloat(button.tag)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.scrollView.contentOffset.x = scrollViewOffsetX
        })
       
    }
    
    //MARK: - YNPorterhouseOrderViewDelegate
    func porterhouseOrderViewCrollViewScrolledEnable(enable: Bool) {
        
            self.scrollView.scrollEnabled = enable
    }
    
    func porterhouseOrderViewDoneButtonDidClick(controller: YNPorterhouseOrderView) {
        
        let orderFormVc: YNOrderFormViewController = YNOrderFormViewController()
        orderFormVc.selectedArray = controller.selectedArray
        self.navigationController?.pushViewController(orderFormVc, animated: true)
    }
    
    func porterhouseOrderViewInteractivePopGestureRecognizer(enabled: Bool) {
        
        self.navigationController?.interactivePopGestureRecognizer!.enabled = enabled
    }
    //MARK: - private proporty
    
    private var typeArray: Array<YNPorthouseType> = [YNPorthouseType]()
    
    private let topListHeight: CGFloat = 44
    private let topListY: CGFloat = 64
    private let kIndicatorHeight: CGFloat = 2
    private let page: CGFloat = 3
    private let space: CGFloat = 15
    
    private var indicatorWidth: CGFloat {
   
        get {
       
            return self.view.frame.size.width/self.page
        }
    }
    private var indicatorY: CGFloat {
   
        get {
       
            return self.topListY + self.topListHeight
        }
    }
    
    private lazy var indicator: UIView = {
        
        var tempView = UIView(frame: CGRectMake(0, self.indicatorY, self.indicatorWidth, self.kIndicatorHeight))
        tempView.backgroundColor = kStyleColor
        return tempView
        
        }()
    
    private lazy var topListView: YNPorterhouseTopListView = {
        
        var temp = YNPorterhouseTopListView(frame: CGRectMake(0, self.topListY, self.view.frame.size.width, self.topListHeight))
        temp.delegate = self
        return temp
        
        }()
    
    private lazy var scrollView:UIScrollView = {
        
        let tempWidth = kScreenWidth + self.space
        let tempHeight = self.view.frame.size.height - CGRectGetMaxY(self.indicator.frame)
        
        let tempY = CGRectGetMaxY(self.indicator.frame)
        var temp = UIScrollView(frame: CGRectMake(0, tempY, tempWidth, tempHeight))
        
        let tempPage: Int = Int(self.page)
        let contentWidth = self.view.frame.size.width * CGFloat(tempPage) + CGFloat(tempPage) * self.space
        temp.contentSize = CGSizeMake(contentWidth, 0)
        
        temp.pagingEnabled = true
        temp.directionalLockEnabled = true
        temp.delegate = self
        temp.showsHorizontalScrollIndicator = false
        
        return temp
        
        }()
}
