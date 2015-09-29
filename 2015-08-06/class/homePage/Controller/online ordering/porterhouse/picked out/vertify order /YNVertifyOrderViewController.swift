//
//  YNVertifyOrderViewController.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/24.
//  Copyright © 2015年 农盟. All rights reserved.
//

import UIKit

class YNVertifyOrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, YNVertifyOrderPaymentTableViewCellDelegate {

    //MARK: - public proporty
    var restaurant: Restaurant?
    var totalPrice: Float?
    
    lazy var payment: Array<PayWay> = {
        
        let pay1Dic: NSDictionary = ["id": "11", "name": "支付宝支付", "selected": true, "discount": 0]
        let pay1 = PayWay(dict: pay1Dic)
        
        let pay2Dic: NSDictionary = ["id": "12", "name": "微信支付", "selected": false, "discount": 0]
        let pay2 = PayWay(dict: pay2Dic)
        
        var tempArray = [pay1, pay2]
        
        return tempArray
        
        }()
    
    
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
        self.view.addSubview(doneButton)
        
    }
    func setupLayout() {
        
        //tableView
        Layout().addLeftTopRightConstraints(tableView, toView: self.view, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(tableView, toView: self.view, multiplier: 1, constant: -50)
        
        //doneButton
        Layout().addTopToBottomConstraint(doneButton, toView: tableView, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(doneButton, toView: self.view, multiplier: 1, constant: -6)
        Layout().addLeftConstraint(doneButton, toView: self.view, multiplier: 1, constant: 12)
        Layout().addRightConstraint(doneButton, toView: self.view, multiplier: 1, constant: -12)
    }
    
  //MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 54
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
        
        
        if indexPath.section == 1 {
        
            let identify: String = "CELL_Payment"
            var paymentCell: YNVertifyOrderPaymentTableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? YNVertifyOrderPaymentTableViewCell
            
            if paymentCell == nil {
                
                paymentCell = YNVertifyOrderPaymentTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
                
            }
            
            paymentCell?.delegate = self
            
            if indexPath.row == 0 {
            
                paymentCell?.iamgeNmae = "icon_alipay"
               paymentCell?.payWay = payment[indexPath.row]
                
            } else if indexPath.row == 1 {
            
                paymentCell?.payWay = payment[indexPath.row]
                paymentCell?.iamgeNmae = "icon_weixin_app"
            }
            
            return paymentCell!
        
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
    
    //MARK: - YNVertifyOrderPaymentTableViewCellDelegate
    func vertifyOrderPaymentCellSelectedButtonDidClick(cell: YNVertifyOrderPaymentTableViewCell) {
        
        if cell.payWay!.selected {
            
            let payWayId = cell.payWay!.id
            
            for item in payment {
                
                let itemId = item.id
                
                if itemId == payWayId {
                    
                    item.selected = cell.payWay!.selected
                    
                } else {
                    
                    item.selected = false
                }
                
            }
            
        }  else {
            
            for item in payment {
                
                if item.id == cell.payWay!.id {
                    
                    item.selected = cell.payWay!.selected
                    break
                }
                
            }
        }
        
        self.tableView.reloadData()
        
    }
    
    //MARK: - event response
    func doneButtonDidClick() {
    
        let orderSuccessVc = YNOrderSuccessViewController()
        
        self.navigationController?.pushViewController(orderSuccessVc, animated: true)
    
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
    
    private lazy var doneButton: UIButton =  {
    
        var tempView = UIButton()
        tempView.layer.cornerRadius = 6
        tempView.clipsToBounds = true
        tempView.setTitle("立即支付", forState: UIControlState.Normal)
        tempView.backgroundColor = kStyleColor
        tempView.translatesAutoresizingMaskIntoConstraints = false
        tempView.addTarget(self, action: "doneButtonDidClick", forControlEvents: UIControlEvents.TouchUpInside)
        return tempView
    }()
    
}
