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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 54
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let identify: String = "CELL_RestaurantName"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identify)
        
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identify)
            
        }
        
        if (indexPath as NSIndexPath).section == 0 {
            
            if (indexPath as NSIndexPath).row == 0 {
            
                cell?.textLabel?.text = restaurant?.title
                return cell!
            }
            
            
            if (indexPath as NSIndexPath).row == 1 {
            
            
                let identify: String = "CELL_RestaurantName"
                var vertifyCell: YNVertifyOrderTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identify) as? YNVertifyOrderTableViewCell
                
                if vertifyCell == nil {
                    
                    vertifyCell = YNVertifyOrderTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identify)
                    
                }
            
                vertifyCell?.totalPrice = self.totalPrice
                return vertifyCell!
            }
        }
        
        
        if (indexPath as NSIndexPath).section == 1 {
        
            let identify: String = "CELL_Payment"
            var paymentCell: YNVertifyOrderPaymentTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identify) as? YNVertifyOrderPaymentTableViewCell
            
            if paymentCell == nil {
                
                paymentCell = YNVertifyOrderPaymentTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identify)
                
            }
            
            paymentCell?.delegate = self
            
            if (indexPath as NSIndexPath).row == 0 {
            
                paymentCell?.iamgeNmae = "icon_alipay"
               paymentCell?.payWay = payment[(indexPath as NSIndexPath).row]
                
            } else if (indexPath as NSIndexPath).row == 1 {
            
                paymentCell?.payWay = payment[(indexPath as NSIndexPath).row]
                paymentCell?.iamgeNmae = "icon_weixin_app"
            }
            
            return paymentCell!
        
        }
        
        cell?.textLabel?.text = "rose"
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
        
            let cell = UITableViewCell()
            cell.textLabel?.text = "支付方式"
            cell.textLabel?.textColor = UIColor.gray
            return cell
        }
        
        return nil
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    
        if section == 0 {
        
          return 10
        }
        
        return 30
    }
    
    //MARK: - YNVertifyOrderPaymentTableViewCellDelegate
    func vertifyOrderPaymentCellSelectedButtonDidClick(_ cell: YNVertifyOrderPaymentTableViewCell) {
        
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
    fileprivate let bottomViewHeight: CGFloat = 50
    fileprivate let bottomSepatatorHeight: CGFloat = 0.6
    
    fileprivate lazy var tableView: UITableView = {
        
        var tempTableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.translatesAutoresizingMaskIntoConstraints = false
        tempTableView.backgroundColor = UIColor.clear
        return tempTableView
        
        }()
    
    fileprivate lazy var doneButton: UIButton =  {
    
        var tempView = UIButton()
        tempView.layer.cornerRadius = 6
        tempView.clipsToBounds = true
        tempView.setTitle("立即支付", for: UIControlState())
        tempView.backgroundColor = kStyleColor
        tempView.translatesAutoresizingMaskIntoConstraints = false
        tempView.addTarget(self, action: #selector(YNVertifyOrderViewController.doneButtonDidClick), for: UIControlEvents.touchUpInside)
        return tempView
    }()
    
}
