//
//  YNOrderFormViewController.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/16.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

class YNOrderFormViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: - life cycle 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "订单确认"
        self.view.backgroundColor = UIColor(red: 234/255.0, green: 234/255.0, blue: 234/255.0, alpha: 1)
        
        self.view.addSubview(tableView)
        
        setLayout()
    }
    
    func setLayout() {
   
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
       
            return 72
        }
        return 44
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 16
    }
//
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        
//        return 50
//    }
    
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
