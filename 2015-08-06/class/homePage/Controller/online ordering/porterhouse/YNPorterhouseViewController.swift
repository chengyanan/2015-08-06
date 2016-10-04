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
        
        loaddata()
        
        self.title = restaurant?.title
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(topListView)
        self.view.addSubview(indicator)
        self.view.addSubview(scrollView)
        
        addViewToScrollView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let window = UIApplication.shared.keyWindow!
        
        
        for subview in window.subviews {
            
                if subview.tag == 100 {
                    
                    subview.removeFromSuperview()
                }
        }

    }
    
    //MARK: - data
    func loaddata() {
   
        let path = Bundle.main.path(forResource: "dishs", ofType: "plist")
        
        if let tempPath = path {
       
            let dataDict: NSDictionary = NSDictionary(contentsOfFile: tempPath)!
            
            if let status: Int = dataDict["status"] as? Int{
            
                if status == 1 {
               
                    let typeArray: NSArray = dataDict["data"] as! NSArray
                    
                    if typeArray.count > 0 {
                   
                        for i in 0 ..< typeArray.count {
                       
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
        
        for i in 0 ..< Int(self.page) {
       
            let viewX = self.scrollView.frame.size.width * CGFloat(i)
            
            let view: UIView = UIView()
            
            view.frame = CGRect(x: viewX, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
            
            var tempSubView: UIView?
            
            if i == 0 {
           
               let orderView = YNPorterhouseOrderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.scrollView.frame.size.height))
                orderView.data = self.typeArray
                orderView.superViewTopViewHeight = self.topListHeight + self.kIndicatorHeight
                orderView.delegate = self
                
                view.addSubview(orderView)
                
            } else if i == 1 {
           
                tempSubView = YNPorterhouseValuationView()
                
            } else if i == 2 {
                
                tempSubView = YNPorterhouseDetailView()
            }
            
            tempSubView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.scrollView.frame.size.height)
            
            if let item = tempSubView {
           
                view.addSubview(item)
            }
        
            self.scrollView.addSubview(view)
        }
        
    }
    
    //MAEK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let x = scrollView.contentOffset.x / 3
        
        self.indicator.frame = CGRect(x: x, y: self.indicatorY, width: self.indicatorWidth, height: self.kIndicatorHeight)
        
        let tempPage = scrollView.contentOffset.x / scrollView.frame.size.width
        
        if  tempPage == 0 {
       
            self.topListView.currentSelected = YNPorterhouseTopListSelected.commodity
            
        } else if tempPage == 1 {
            
            self.topListView.currentSelected = YNPorterhouseTopListSelected.appraisal
            
        } else if tempPage == 2 {
            
            self.topListView.currentSelected = YNPorterhouseTopListSelected.business
        }
        
    }
    
    //MARK: - YNPorterhouseTopListViewDelegate
    func topListViewButtonTapped(_ button: UIButton) {
        
        let scrollViewOffsetX = self.scrollView.frame.size.width * CGFloat(button.tag)
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
            self.scrollView.contentOffset.x = scrollViewOffsetX
        })
       
    }
    
    //MARK: - YNPorterhouseOrderViewDelegate
    func porterhouseOrderViewCrollViewScrolledEnable(_ enable: Bool) {
        
            self.scrollView.isScrollEnabled = enable
    }
    
    
    func porterhouseOrderViewDoneButtonDidClick(_ controller: YNPorterhouseOrderView, totalPrice: Float) {
        let orderFormVc: YNOrderFormViewController = YNOrderFormViewController()
        orderFormVc.restaurant = restaurant
        orderFormVc.selectedArray = controller.selectedArray
        orderFormVc.totalPrice = totalPrice
        self.navigationController?.pushViewController(orderFormVc, animated: true)

    }
    
    func porterhouseOrderViewInteractivePopGestureRecognizer(_ enabled: Bool) {
        
        // 禁止或开启使用系统自带的滑动手势
        self.navigationController?.interactivePopGestureRecognizer!.isEnabled = enabled
    }
    //MARK: - private proporty
    
    fileprivate var typeArray: Array<YNPorthouseType> = [YNPorthouseType]()
    
    fileprivate let topListHeight: CGFloat = 44
    fileprivate let topListY: CGFloat = 64
    fileprivate let kIndicatorHeight: CGFloat = 2
    fileprivate let page: CGFloat = 3
    fileprivate let space: CGFloat = 15
    
    fileprivate var indicatorWidth: CGFloat {
   
        get {
       
            return self.view.frame.size.width/self.page
        }
    }
    fileprivate var indicatorY: CGFloat {
   
        get {
       
            return self.topListY + self.topListHeight
        }
    }
    
    fileprivate lazy var indicator: UIView = {
        
        var tempView = UIView(frame: CGRect(x: 0, y: self.indicatorY, width: self.indicatorWidth, height: self.kIndicatorHeight))
        tempView.backgroundColor = kStyleColor
        return tempView
        
        }()
    
    fileprivate lazy var topListView: YNPorterhouseTopListView = {
        
        var temp = YNPorterhouseTopListView(frame: CGRect(x: 0, y: self.topListY, width: self.view.frame.size.width, height: self.topListHeight))
        temp.delegate = self
        return temp
        
        }()
    
    fileprivate lazy var scrollView:UIScrollView = {
        
        let tempWidth = kScreenWidth + self.space
        let tempHeight = self.view.frame.size.height - self.indicator.frame.maxY
        
        let tempY = self.indicator.frame.maxY
        var temp = UIScrollView(frame: CGRect(x: 0, y: tempY, width: tempWidth, height: tempHeight))
        
        let tempPage: Int = Int(self.page)
        let contentWidth = self.view.frame.size.width * CGFloat(tempPage) + CGFloat(tempPage) * self.space
        temp.contentSize = CGSize(width: contentWidth, height: 0)
        
        temp.isPagingEnabled = true
        temp.isDirectionalLockEnabled = true
        temp.delegate = self
        temp.showsHorizontalScrollIndicator = false
        
        return temp
        
        }()
}
