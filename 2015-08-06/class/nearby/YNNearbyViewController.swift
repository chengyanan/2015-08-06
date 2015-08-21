//
//  YNNearbyViewController.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/6.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class YNNearbyViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    let kAccuracy = 0.01
    
    let kLatitudeDelta = 0.0142737102703023
    let kLongitudeDelta = 0.0122213804488638
    
    lazy var titleView: YNNearbyTitleView = {
    
    return YNNearbyTitleView(frame: CGRectMake(self.view.frame.size.width/2, 20, 156, 44))
    
    }()
    
    lazy var locationManger: CLLocationManager = {
        var tempLocationManager = CLLocationManager()
        tempLocationManager.pausesLocationUpdatesAutomatically = true
        tempLocationManager.delegate = self
        tempLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        tempLocationManager.distanceFilter = 10
        return tempLocationManager
        }()
    lazy var geocder: CLGeocoder = {
        return CLGeocoder()
        }()
    
    lazy var mapView: MKMapView = {
        var tempMapView = MKMapView(frame: self.view.bounds)
        tempMapView.mapType = MKMapType.Standard
        tempMapView.showsUserLocation = true
        tempMapView.userTrackingMode = MKUserTrackingMode.Follow
        tempMapView.delegate = self
        return tempMapView
        }()
    
    
    var coordinate: CLLocationCoordinate2D? {
        
        didSet {
        
            if isLoadData {
           
                self.getDataFromServer()
            }
            
        }
       
    }
    var callOutAnnotationView: YNCallOutAnnotationView?
    var callOutAnnotation: YNCallOutAnnotation?
    
    var isLocated:Bool = false//是否是第一次定位
    var isDeleteAnnotation: Bool = false//是否要删除当前界面上的calloutView
    var isLoadData: Bool = true//知道当前数据加载完毕,才能重新加载数据,防止用户快速移动的时候,不停的发送请求
    
    
    lazy var baseAnnocationArray: NSMutableArray? = {
        
        return NSMutableArray()
        }()
    
    lazy var dataArray: Array<Restaurant> = {
        
        return Array()
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLocate()
        self.view.addSubview(self.mapView)
        
        self.navigationItem.titleView = self.titleView
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    
    //MARK: - get data from server
    
    func getDataFromServer() {
        
        let lat = "\(self.coordinate!.latitude)"
        let lon = "\(self.coordinate!.longitude)"
        
        var params = ["key":"edge5de7se4b5xd",
                   "action": "getnearmark",
                     "type": "restaurant",
                      "lat": lat,
                      "lon": lon]
        
        self.titleView.start()
        
        Network.get(kURL, params: params  , success: { (data, response, error) -> Void in
    
            self.titleView.end()
            self.isLoadData = false
            
            
            let json: NSDictionary! =  NSJSONSerialization.JSONObjectWithData(data! , options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
           
//                print("data - \(json)\n")
            
                if let status = json["status"] as? Int {
                    
                    if status == 1 {
                        
                        if let restaurantArray = json["data"] as? NSArray {
                        
                            
                            self.dataProcessing(restaurantArray)
                            
                        } else {
                       
                            YNProgressHUD().showText("数组不存在,此地区没有数据", toView: self.view)
                        }
                        
                        
                    } else if status == 0 {
                        
                        self.isLoadData = true
                        
                        if let msg = json["msg"] as? String {
                            
                            YNProgressHUD().showText(msg, toView: self.view)
                        }
                        
                    }
                    
                }
            
            
        }) { (error) -> Void in
        
            self.titleView.end()
            YNProgressHUD().showText("请求失败,请检查网络", toView: self.view)
            self.isLoadData = true
        }
    }
    
    func dataProcessing(dataArray: NSArray) {
   
        if dataArray.count > 0 {
       
            for restaurant in dataArray {
                
                let tempRestaurant = Restaurant(dict: restaurant as! NSDictionary)
                self.dataArray.append(tempRestaurant)
                
            }
            
             addEnterpriseAnnotation()
            
        } else {
       
            YNProgressHUD().showText("此地区没有数据", toView: self.view)
        }
        
    }
    
    
    //MARK: - custom method
    func startLocate() {
   
        let locationServicesEnabled: Bool = CLLocationManager.locationServicesEnabled()
        if locationServicesEnabled {
       
            let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
            if status == CLAuthorizationStatus.NotDetermined {
           
                if self.locationManger.respondsToSelector("requestWhenInUseAuthorization") {
               
                    self.locationManger.requestAlwaysAuthorization()
                }
            }
            
            self.locationManger.startUpdatingLocation()
            
        } else {
       
            YNProgressHUD().showText("该设备无法定位", toView: self.view)
        }
    }
    
    func showMyLocation(coordinate: CLLocationCoordinate2D) {
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(kLatitudeDelta, kLongitudeDelta)
        let regin: MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        self.mapView.setRegion(regin, animated: true)
    }
    
    func addEnterpriseAnnotation() {
        
        let tempArray = NSArray(array: self.baseAnnocationArray!)
        self.mapView.removeAnnotations(tempArray as [AnyObject])
        self.baseAnnocationArray?.removeAllObjects()
        
        for var index = 0; index < self.dataArray.count; ++index {
       
            let restaurant: Restaurant = self.dataArray[index]
            var baseAnnotation: YNBaseAnnotation = YNBaseAnnotation(coordinate: restaurant.coordinate!)
            baseAnnotation.index = index
            self.mapView.addAnnotation(baseAnnotation)
            self.baseAnnocationArray?.addObject(baseAnnotation)
        }
        
        self.isLoadData = true
        
    }
    
    func isUpdateLocation(currentLocation: CLLocationCoordinate2D, userLocation: CLLocationCoordinate2D)-> Bool {
   
        let latitude: Double = currentLocation.latitude - userLocation.latitude
        let longitude: Double = currentLocation.longitude - userLocation.longitude
        
        let latitudeSatify: Bool = latitude > kAccuracy || latitude < -kAccuracy
        let longitudeSatify: Bool = longitude > kAccuracy || longitude < -kAccuracy
    
        if latitudeSatify || longitudeSatify {
       
            return true
        }
        
        return false
        
    }
    
    func reverseGeocodeLocationWithUserLocation(userLocation: MKUserLocation!) {
   
        self.geocder.reverseGeocodeLocation(userLocation.location, completionHandler: { (placemarks, error) -> Void in
            
            if let place = placemarks {
           
                 let placeMark: CLPlacemark = placemarks.first as! CLPlacemark
                    
                    if let thoroughfare = placeMark.thoroughfare {
                        
                        var title: String = thoroughfare
                        
                        if let subThoroughfare = placeMark.subThoroughfare {
                            
                            title += subThoroughfare
                        }
                        
                        userLocation.title = title
                    }
                    
                }
            
            
        })
        
        if !self.isLocated {
            
            showMyLocation(userLocation.location.coordinate)
            self.isLocated = true
            
        }
    }
    
//MARK: - MKMapViewDelegate
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        
        
        if let tempCoorinate = self.coordinate {
            
            let isUpdateLocation = self.isUpdateLocation(self.coordinate!, userLocation: userLocation.coordinate)
        
            if isUpdateLocation {
           
                //新位置和以前不一样，设置新位置，从新加载数据
                self.coordinate = userLocation.location.coordinate
                reverseGeocodeLocationWithUserLocation(userLocation)
    
            }
            
        }else {
       
            self.coordinate = userLocation.location.coordinate
            reverseGeocodeLocationWithUserLocation(userLocation)
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if annotation is YNBaseAnnotation {
       
            let identify = "PINANNOTATIONVIEW"
            var pinAnnotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier(identify) as? MKPinAnnotationView
            if pinAnnotationView == nil {
                pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identify)
                
            }
            
            pinAnnotationView?.canShowCallout = false
            pinAnnotationView?.pinColor = MKPinAnnotationColor.Purple
            return pinAnnotationView
            
        } else if annotation is YNCallOutAnnotation {
       
            let callOutidentify = "CALLOUTANNOTATIONVIEW"
            var callOutAnnotationView: YNCallOutAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier(callOutidentify) as? YNCallOutAnnotationView
            if callOutAnnotationView == nil {
                
                callOutAnnotationView = YNCallOutAnnotationView(annotation: annotation, reuseIdentifier: callOutidentify)
            }
            
            callOutAnnotationView!.alpha = 1.0
            self.callOutAnnotationView = callOutAnnotationView
            
            return callOutAnnotationView
        }
        
        
        return nil
    }
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        
        if view.annotation is YNBaseAnnotation {
       
            self.isDeleteAnnotation = false
            var baseAnnotation: YNBaseAnnotation = view.annotation as! YNBaseAnnotation
            
            //TODO: 纪录 baseAnnotation.index
            
            var callOutAnnotation = YNCallOutAnnotation(coordinate: view.annotation.coordinate)
            mapView.addAnnotation(callOutAnnotation)
            self.callOutAnnotation = callOutAnnotation
        }
        
    }
    
    func mapView(mapView: MKMapView!, didDeselectAnnotationView view: MKAnnotationView!) {
        
        if let tempCallOutAnnotation = self.callOutAnnotation {
            
            self.isDeleteAnnotation = true
            
            UIView.animateWithDuration(0.3 , animations: { () -> Void in
                
                self.callOutAnnotationView!.alpha = 0.0
                
            }, completion: { (finished) -> Void in
                
                if self.isDeleteAnnotation {
               
                    self.mapView.removeAnnotation(self.callOutAnnotation)
                    self.callOutAnnotation = nil
                }
                
            })
            
        }
        
    }
    
//    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
//        
//       print("\n\(mapView.region.span.latitudeDelta), \(mapView.region.span.longitudeDelta)\n")
//    }
}