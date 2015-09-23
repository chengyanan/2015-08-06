//
//  YNPorterhouseType.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/6.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import Foundation

class YNPorthouseType {
    
    //类别名称
    var title: String?
    
    //类别下的菜品
    var dataArray = [YNPorterhouseDish]()
    
    //当前类别是否被选中
    var selected: Bool = false
    
    var firstIndex = 0 {
   
        didSet {
       
            for item in self.dataArray {
           
                item.firstIndex = firstIndex
            }
        }
    }
    
    //这个类别下选中了多少菜品
    var selectedNumber: Int = 0
    
    init(dict: NSDictionary) {
        
        title = dict["title"] as? String
        
        let dataDict = dict["dataArray"] as? Array<NSDictionary>
        
        if let tempData = dataDict {
            
            for var i = 0; i < tempData.count; ++i {
           
                let data = YNPorterhouseDish(dict: tempData[i])
                data.secondIndex = i
                dataArray.append(data)
            }
            
            
        } else {
       
            print("\n --- YNPorthouseType: -- 数组转化失败 \n", terminator: "")
        }
    }
}