//
//  YNPorterhouseDish.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/6.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import Foundation

class YNPorterhouseDish {
    
    //图片url
    var imageURL: String?
    //名称
    var name: String?
    //月销量
    var monthSales: Double?
    //价格
    var price: Float?
    //总热量
    var calories: Float?
    
    
    //被选中的数量
    var number: Int = 0
    
    init(dict: NSDictionary) {
   
        imageURL = dict["imageURL"] as? String
        name = dict["name"] as? String
        monthSales = dict["monthSales"] as? Double
        price = dict["price"] as? Float
        calories = dict["calories"] as? Float
        
    }
    
}