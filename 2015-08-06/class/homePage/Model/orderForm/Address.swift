//
//  Address.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/22.
//  Copyright © 2015年 农盟. All rights reserved.
//

import Foundation

class Address {
    
    var userName: String?
    var userGender: String?
    var userPhone: String?
    var cityID: String?
    var cityName: String?
    var buildingName: String?
    var details: String?
    var selected: Bool?
    
    init(dict: NSDictionary) {
   
        userName = dict["userName"] as? String
        userGender = dict["userGender"] as? String
        userPhone = dict["userPhone"] as? String
        cityID = dict["cityID"] as? String
        cityName = dict["cityName"] as? String
        buildingName = dict["buildingName"] as? String
        details = dict["details"] as? String
        selected = dict["selected"] as? Bool
    }
}