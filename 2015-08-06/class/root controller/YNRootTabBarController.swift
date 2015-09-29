//
//  YNRootTabBarController.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/6.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

class YNRootTabBarController: UITabBarController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tabBar.tintColor = kStyleColor
        
        let homepageVc = YNHomePageViewController()
         let homepageNav = YNNavigationController(rootViewController: homepageVc)
         homepageVc.title = "首页"
        homepageNav.tabBarItem.image = UIImage(named: "tabBar_homePage_off")
        homepageNav.tabBarItem.title = "首页"
        
//        let nearbyVc = YNNearbyViewController()
//        let nearbyNav = YNNavigationController(rootViewController: nearbyVc)
//        nearbyVc.title = "我附近的热门商家"
//        nearbyNav.tabBarItem.image = UIImage(named: "tarBar_nearby_off")
//        nearbyNav.tabBarItem.title = "附近"
        
        let ordersVc = YNCustomerOrdersViewController()
        let ordersnav = YNNavigationController(rootViewController: ordersVc)
        ordersVc.title = "订单"
        ordersnav.tabBarItem.image = UIImage(named: "tarBar_nearby_off")
        ordersnav.tabBarItem.title = "订单"
        
        let meVc = YNMeViewController()
        let meNav = YNNavigationController(rootViewController: meVc)
        meVc.title = "我"
        meNav.tabBarItem.image = UIImage(named: "tabBar_more_off")
        meNav.tabBarItem.title = "我的"
    
        self.viewControllers = [homepageNav, ordersnav, meNav]
        
    }
    

}
