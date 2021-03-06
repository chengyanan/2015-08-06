//
//  Location.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/1.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class Location: NSObject, CLLocationManagerDelegate {
    
    fileprivate let pi: Double = 3.14159265358979324
    fileprivate let ee: Double = 0.00669342162296594323
    fileprivate let a: Double = 6378245.0
    
    var cooridate: CLLocationCoordinate2D?
    
    func startLocation() {
   
        let locationServicesEnabled: Bool = CLLocationManager.locationServicesEnabled()
        if locationServicesEnabled {
       
            let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
            
            if status == CLAuthorizationStatus.notDetermined {
        
               
                if #available(iOS 8.0, *) {
                    
                    self.locationManager.requestWhenInUseAuthorization()
                    
                } else {
                    
                    // Fallback on earlier versions
                }
                
            }
            
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.distanceFilter = 10
            self.locationManager.startUpdatingLocation()
            
        } else {
       
            YNProgressHUD().showText("定位功能未开启", toView: UIApplication.shared.keyWindow!)
        }
    }
    
    //MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocation: CLLocation = locations[locations.startIndex] 
        
        cooridate = self.transformFromWGSToGCJ(newLocation.coordinate)
        
    }
    
    func transformFromWGSToGCJ(_ wgsLoc: CLLocationCoordinate2D)-> CLLocationCoordinate2D {
   
        var adjustLoc: CLLocationCoordinate2D?
        
        if self.isLocationOutOfChina(wgsLoc) {
            
            adjustLoc = wgsLoc
            
        } else {
       
            var adjustLat: Double = self.transformLatWithX(wgsLoc.longitude - 105.0, y: wgsLoc.latitude - 35.0)
            var adjustLon: Double = self.transformLonWithX(wgsLoc.longitude - 105.0, y: wgsLoc.latitude - 35.0)
            let radLat: Double = wgsLoc.latitude / 180.0 * pi
            var magic: Double = sin(radLat)
            magic = 1 - ee * magic * magic
            let sqrtMagic: Double = sqrt(magic)
            adjustLat = (adjustLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi)
            adjustLon = (adjustLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi)

            adjustLoc = CLLocationCoordinate2DMake(wgsLoc.latitude + adjustLat, wgsLoc.longitude + adjustLon)
            
        }
        
        return adjustLoc!
    }
    
    func isLocationOutOfChina(_ coordinate: CLLocationCoordinate2D)->Bool {
   
        if (coordinate.longitude < 72.004 || coordinate.longitude > 137.8347 || coordinate.latitude < 0.8293 || coordinate.latitude > 55.8271) {
       
            return true
        }
        
        return false
    }
    
    func transformLatWithX(_ x: Double, y: Double)->Double {
   
        let temp = 0.2 * sqrt(fabs(x))
        let lat: Double = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + temp
//        lat += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0
//        lat += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0
//        
//        lat += (160.0 * sin(y / 12.0 * pi) + 3320 * sin(y * pi / 30.0)) * 2.0 / 3.0
//        
        return lat
    }
    
    func transformLonWithX(_ x: Double, y: Double)->Double {
        
        let temp = 0.1 * sqrt(fabs(x))
        let lon: Double = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + temp
        
//        lon += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0
//        lon += (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0
//        lon += (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0 * pi)) * 2.0 / 3.0
        return lon
        
    }
    
    fileprivate lazy var locationManager: CLLocationManager = {
        
        var tempLm: CLLocationManager = CLLocationManager()
        tempLm.pausesLocationUpdatesAutomatically = true
        return tempLm
        
        }()
    
}
