//
//  Macro.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/7.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import Foundation
import UIKit

let kUserKey = "User_MobileNumber"

func kUser_MobileNumber() ->AnyObject? {
   
     return UserDefaults.standard.value(forKey: kUserKey) as AnyObject?
}

let kURL = "http://www.24ag.com/app/api.php"
let kNearByURL = "http://www.24ag.com/api.php"

let kStyleColor = UIColor.red
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

func kIS_iPhone4() ->Bool { return kScreenHeight == 480}
func kIS_iPhone5() ->Bool { return kScreenHeight == 568}
func kIS_iPhone6() ->Bool {return kScreenHeight == 667}

func kIOS7() ->Bool { return atof(UIDevice.current.systemVersion) < 8 }

func kIS_iPhone6Plus() ->Bool {return kScreenHeight > 667}

func kRGBA(_ r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) ->UIColor { return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)}

