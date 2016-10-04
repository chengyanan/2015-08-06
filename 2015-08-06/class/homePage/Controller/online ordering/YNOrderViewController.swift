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
    
    
    fileprivate var dataArray: Array<Restaurant>? {
   
        didSet {
       
//            self.setupInterface()
            self.tableView.reloadData()
            
        }
    }
    
    fileprivate lazy var tableView: UITableView = {
        
        var tempTableView: UITableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        return tempTableView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "餐厅"
        self.view.backgroundColor = UIColor.white
        
        setupInterface()
    }
    
    //MARK: - private method
    
    func setupInterface() {
   
        self.view.addSubview(tableView)
    }
    
    //从服务器加载数据
    func getDataFromServer() {
        
        let lat = "\(self.cooridate!.latitude)"
        let lon = "\(self.cooridate!.longitude)"
        
        let params: [String: String?] = ["key":"edge5de7se4b5xd",
            "action": "getnearmark",
            "type": "restaurant",
            "lat": lat,
            "lon": lon]
        
        let progress: ProgressHUD = YNProgressHUD().showWaitingToView(self.view)
        
        Network.get(kURL, params: params  , success: { (data, response, error) -> Void in
            
            progress.hideUsingAnimation()
            
            let json: NSDictionary! =  (try! JSONSerialization.jsonObject(with: data , options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            
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
    
    func dataProcessing(_ dataArray: NSArray) {
        
        if dataArray.count > 0 {
            
            var tempDataArray: Array<Restaurant> = Array()
                        
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = dataArray {
       
            return dataArray!.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identify: String = "CELL_ORDERORRESERVE"
        var cell: YNOrderTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identify) as? YNOrderTableViewCell
        if cell == nil {
            
            cell = YNOrderTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identify)
        }
        
        if let _ = self.dataArray {
       
             cell?.dataModel = self.dataArray![(indexPath as NSIndexPath).row]
        }
    
        return cell!
        
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let porterhouseVc: YNPorterhouseViewController = YNPorterhouseViewController()
        
        if let _ = self.dataArray {
       
            porterhouseVc.restaurant = self.dataArray![(indexPath as NSIndexPath).row]
        }
        
        self.navigationController?.pushViewController(porterhouseVc, animated: true)
    }
    
    
    
}
