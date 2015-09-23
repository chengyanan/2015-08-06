//
//  OrderForm.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/22.
//  Copyright © 2015年 农盟. All rights reserved.
//

import Foundation

class OrderForm {
    
//    var addresses = [Address]()
    var payWay = [PayWay]()
    var remark: String?
    var discount: Int = 0
    
    init(dict: NSDictionary) {
        
        remark = dict["remark"] as? String
        discount = dict["discount"] as! Int
        
//        let addressArray = dict["addresses"] as! NSArray
//        
//        if addressArray.count > 0 {
//       
//            let tempaddress = Address(dict: addressArray[0] as! NSDictionary)
//            addresses.append(tempaddress)
//        }
        
        let payWayArray = dict["payWay"] as! NSArray
        
        if payWayArray.count > 0 {
       
            for item in payWayArray {
           
                let payment = PayWay(dict: item as! NSDictionary)
                payWay.append(payment)
            }
        }
        
    }
    
    
    
}