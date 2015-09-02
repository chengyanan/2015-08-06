//
//  YNOrderViewController.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/31.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit
import CoreLocation

class YNOrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var cooridate: CLLocationCoordinate2D? {
    
        didSet {
       
            self.getDataFromServer()
        }
        
    }
    
    
    private var dataArray: Array<Restaurant>? {
   
        didSet {
       
            self.tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        
        var tempTableView: UITableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        return tempTableView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "餐厅"
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(tableView)
    }
    
    
    //从服务器加载数据
    func getDataFromServer() {
        
        let lat = "\(self.cooridate!.latitude)"
        let lon = "\(self.cooridate!.longitude)"
        
        var params = ["key":"edge5de7se4b5xd",
            "action": "getnearmark",
            "type": "restaurant",
            "lat": lat,
            "lon": lon]
        
        var progress: ProgressHUD = YNProgressHUD().showWaitingToView(self.view)
        
        Network.get(kURL, params: params  , success: { (data, response, error) -> Void in
            
            progress.hideUsingAnimation()
            
            let json: NSDictionary! =  NSJSONSerialization.JSONObjectWithData(data! , options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            
//                            print("\ndata - \(json)\n")
            
            if let status = json["status"] as? Int {
                
                if status == 1 {
                    
                    if let restaurantArray = json["data"] as? NSArray {
                        
                        
                        self.dataProcessing(restaurantArray)
                        
                    } else {
                        
                        YNProgressHUD().showText("数组不存在,此地区没有数据", toView: self.view)
                    }
                    
                    
                } else if status == 0 {
                    
                    if let msg = json["msg"] as? String {
                        
                        YNProgressHUD().showText(msg, toView: self.view)
                    }
                    
                }
                
            }
            
            
            }) { (error) -> Void in
                
               progress.hideUsingAnimation()
                YNProgressHUD().showText("请求失败,请检查网络", toView: self.view)
    
        }
    }
    
    func dataProcessing(dataArray: NSArray) {
        
        if dataArray.count > 0 {
            
            var tempDataArray: Array<Restaurant> = Array()
            
//            for _ in 0...20 {
//           
//                for restaurant in dataArray {
//                    
//                    let tempRestaurant = Restaurant(dict: restaurant as! NSDictionary)
//                    tempDataArray.append(tempRestaurant)
//                    
//                }
//            }
            
            for restaurant in dataArray {
                
                let tempRestaurant = Restaurant(dict: restaurant as! NSDictionary)
                tempDataArray.append(tempRestaurant)
                
            }
            
            self.dataArray = tempDataArray
            
        } else {
            
            YNProgressHUD().showText("此地区没有数据", toView: self.view)
        }
        
    }

    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let temparray = dataArray {
       
            return dataArray!.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identify: String = "CELL_ORDERORRESERVE"
        var cell: YNOrderTableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? YNOrderTableViewCell
        if cell == nil {
            
            cell = YNOrderTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
        }
        
        if let tempArray = self.dataArray {
       
             cell?.dataModel = self.dataArray![indexPath.row]
        }
    
        return cell!
        
    }
    
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var porterhouseVc: YNPorterhouseViewController = YNPorterhouseViewController()
        
        if let tempArray = self.dataArray {
       
            porterhouseVc.restaurant = self.dataArray![indexPath.row]
        }
        
        self.navigationController?.pushViewController(porterhouseVc, animated: true)
    }
    
    
    
}
