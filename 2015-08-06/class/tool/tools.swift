//
//  tools.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/10.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import Foundation

struct Tools {
    
   internal func isPhoneNumber(_ phoneNumber: String) ->Bool{
        
        let length = phoneNumber.lengthOfBytes(using: String.Encoding.utf8)
        
        if  length != 11  {return false}
        let regular = "^1[3|4|5|7|8|9][0-9]{9}$"
        
        let regex = try? NSRegularExpression(pattern: regular, options: NSRegularExpression.Options.anchorsMatchLines)
        
        let resault: NSTextCheckingResult! =  regex?.firstMatch(in: phoneNumber, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, length))
        
        let range = resault.range
        
        return (range.length == 11)
    }
    
    func saveValue(_ value: AnyObject?, forKey: String) {
   
        let userDefault: UserDefaults = UserDefaults.standard
        
        userDefault.setValue(value, forKey: forKey)
    }
    
    func valueForKey(_ forKey: String) ->AnyObject? {
   
        let userDefault: UserDefaults = UserDefaults.standard
        
        return userDefault.value(forKey: forKey) as AnyObject?
        
    }
    
    func removeValueForKey(_ forKey: String) {
   
        let userDefault: UserDefaults = UserDefaults.standard
        userDefault.removeObject(forKey: forKey)
    }
}

