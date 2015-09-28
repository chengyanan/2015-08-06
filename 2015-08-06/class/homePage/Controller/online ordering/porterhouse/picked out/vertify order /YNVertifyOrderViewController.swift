//
//  YNVertifyOrderViewController.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/24.
//  Copyright © 2015年 农盟. All rights reserved.
//

import UIKit

class YNVertifyOrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: - public proporty
    var restaurant: Restaurant?
    var totalPrice: Float?
    
    //MARK: - lift cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "支付收银台"
        self.view.backgroundColor = UIColor(red: 234/255.0, green: 234/255.0, blue: 234/255.0, alpha: 1)
        
        setupInterface()
        setupLayout()
    }

    func setupInterface() {
        
        self.view.addSubview(tableView)
        
    }
    func setupLayout() {
        
        //tableView
        Layout().addLeftTopRightConstraints(tableView, toView: self.view, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(tableView, toView: self.view, multiplier: 1, constant: -50)
        

    }
    
  //UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let identify: String = "CELL_RestaurantName"
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify)
        
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
            
        }
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
            
                cell?.textLabel?.text = restaurant?.title
                return cell!
            }
            
            
            if indexPath.row == 1 {
            
            
                let identify: String = "CELL_RestaurantName"
                var vertifyCell: YNVertifyOrderTableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? YNVertifyOrderTableViewCell
                
                if vertifyCell == nil {
                    
                    vertifyCell = YNVertifyOrderTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
                    
                }
            
                vertifyCell?.totalPrice = self.totalPrice
                return vertifyCell!
            }
        }
        
        cell?.textLabel?.text = "rose"
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
        
            let cell = UITableViewCell()
            cell.textLabel?.text = "支付方式"
            cell.textLabel?.textColor = UIColor.grayColor()
            return cell
        }
        
        return nil
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 20
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    
        if section == 0 {
        
          return 10
        }
        
        return 30
    }
    
    //MARK: - private property
    private let bottomViewHeight: CGFloat = 50
    private let bottomSepatatorHeight: CGFloat = 0.6
    
    private lazy var tableView: UITableView = {
        
        var tempTableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
        
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.translatesAutoresizingMaskIntoConstraints = false
        tempTableView.backgroundColor = UIColor.clearColor()
        return tempTableView
        
        }()
    
}
