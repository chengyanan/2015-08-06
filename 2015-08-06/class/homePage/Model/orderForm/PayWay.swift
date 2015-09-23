//
//  PayWay.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/22.
//  Copyright © 2015年 农盟. All rights reserved.
//

import Foundation

class PayWay {
    
    var id: String?
    var name: String?
    var selected: Bool = false
    var discount: Int = 0
    
    init(dict: NSDictionary) {
   
        id = dict["id"] as? String
        name = dict["name"] as? String
        selected = (dict["selected"] as? Bool)!
        discount = dict["discount"] as! Int
        
    }
}