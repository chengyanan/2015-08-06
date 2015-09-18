//
//  YNOrderFormViewController.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/16.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

class YNOrderFormViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: - public proporty
    var selectedArray: Array<YNPorterhouseDish>?  {
   
        didSet {
            
            setupInterface()
            setupLayout()
            
        }
    }
    
    //MARK: - life cycle 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 恢复系统自带的滑动手势
        self.navigationController?.interactivePopGestureRecognizer.enabled = true
        
        self.title = "订单确认"
        self.view.backgroundColor = UIColor(red: 234/255.0, green: 234/255.0, blue: 234/255.0, alpha: 1)
        
        
//        setupInterface()
//        setupLayout()
    }
    
    func setupInterface() {
   
        self.view.addSubview(tableView)
    }
    
    func setupLayout() {
   
        Layout().addTopConstraint(tableView, toView: self.view, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(tableView, toView: self.view, multiplier: 1, constant: 0)
        Layout().addLeftConstraint(tableView, toView: self.view, multiplier: 1, constant: 0)
        Layout().addRightConstraint(tableView, toView: self.view, multiplier: 1, constant: 0)
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return numberOfCellArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 4 {
       
            return selectedArray!.count
        }
        
        return numberOfCellArray[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
       
            let identify: String = "CELL_userAddress"
            var cell: YNOrderFormAddressCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? YNOrderFormAddressCell
            
            if cell == nil {
                
                cell = YNOrderFormAddressCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
                
            }

            return cell!
        }
        if indexPath.section == 1 {
            
            let identify: String = "CELL_pay"
            var cell: YNOrderFormPayCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? YNOrderFormPayCell
            
            if cell == nil {
                
                cell = YNOrderFormPayCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
                
            }
            
            return cell!
        }
        if indexPath.section == 2 {
            
            let identify: String = "CELL_mealTime"
            var cell: YNMealTimeOrOtherCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? YNMealTimeOrOtherCell
            
            if cell == nil {
                
                cell = YNMealTimeOrOtherCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
                
            }
            
            return cell!
        }
        
        if indexPath.section == 3 {
            
            if indexPath.row == 0 {
           
                let identify: String = "CELL_mealTime"
                var cell: YNOrderFormComponCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? YNOrderFormComponCell
                
                if cell == nil {
                    
                    cell = YNOrderFormComponCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
                    
                }
                
                return cell!
            }
            
            let identify: String = "CELL_delivery"
            var cell: YNOrderFormDeliveryCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? YNOrderFormDeliveryCell
            
            if cell == nil {
                
                cell = YNOrderFormDeliveryCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
                
            }
            
            return cell!
        }
        
        
        if indexPath.section == 4 {
       
            let identify: String = "CELL_SelectDish"
            var cell: YNOrderFormSelectDishCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? YNOrderFormSelectDishCell
            
            if cell == nil {
                
                cell = YNOrderFormSelectDishCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
                
            }
            
            cell?.data = self.selectedArray![indexPath.row]
            
            return cell!
        }
        
        
        let identify: String = "CELL_Address"
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? UITableViewCell
        
        if cell == nil {
       
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
           
        }
        
        cell?.textLabel?.text = "rose"
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
       
            return 80
        }
        
        if indexPath.section == 3 {
       
            if indexPath.row == 1 {
           
                return 64
            }
            
        }
        return 44
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 16
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 1
    }
    
    //MARK: - private property
    
    private lazy var numberOfCellArray = {
   
        return [1, 2, 2, 2, 4]
        
    }()
    
    private lazy var tableView: UITableView = {
        
        var tempTableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return tempTableView
        
        }()
}
