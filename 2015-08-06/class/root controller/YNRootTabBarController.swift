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
        // Do any additional setup after loading the view.
        
        let homepageVc = YNHomePageViewController()
         let homepageNav = YNNavigationController(rootViewController: homepageVc)
         homepageVc.title = "首页"
        homepageNav.tabBarItem.image = UIImage(named: "tabBar_homePage_off")
        homepageNav.tabBarItem.title = "首页"
        
        
//        var activityVc = YNActivityViewController()
//         var activityNav = YNNavigationController(rootViewController: activityVc)
//        activityVc.title = "活动"
//        activityNav.tabBarItem.image = UIImage(named: "tabBar_service_off")
//        activityNav.tabBarItem.title = "活动"
        
        
        let nearbyVc = YNNearbyViewController()
        let nearbyNav = YNNavigationController(rootViewController: nearbyVc)
        nearbyVc.title = "我附近的热门商家"
        nearbyNav.tabBarItem.image = UIImage(named: "tarBar_nearby_off")
        nearbyNav.tabBarItem.title = "附近"
        
        
//        var cycleRingVc = YNCycleRingViewController()
//        var cycleRingNav = YNNavigationController(rootViewController: cycleRingVc)
//        cycleRingVc.title = "圈子"
//        cycleRingNav.tabBarItem.image = UIImage(named: "tabBar_mine_off")
//        cycleRingNav.tabBarItem.title = "圈子"
        
        
        let meVc = YNMeViewController()
        let meNav = YNNavigationController(rootViewController: meVc)
        meVc.title = "我"
        meNav.tabBarItem.image = UIImage(named: "tabBar_more_off")
        meNav.tabBarItem.title = "我的"
        
//        self.viewControllers = [homepageNav, activityNav, nearbyNav, cycleRingNav, meNav]
        
         self.viewControllers = [homepageNav, nearbyNav, meNav]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
