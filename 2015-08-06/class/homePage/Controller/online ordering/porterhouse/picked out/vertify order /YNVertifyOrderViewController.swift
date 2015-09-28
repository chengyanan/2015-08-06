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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "支付收银台"
        self.view.backgroundColor = UIColor.whiteColor()
        
        
    }

    func setupInterface() {
        
        
        
    }
    func setupLayout() {
        
        self.view.addSubview(tableView)
    }
    
  //UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identify: String = "CELL_ID"
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify)
        
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
            
        }
        
        cell?.textLabel?.text = "rose"
        
        return cell!
        
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
