//
//  YNOrderFormViewController.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/16.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

class YNOrderFormViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, YNOrderFormPayCellDelegate, YNOrderFormBottomViewDelegate {

    //MARK: - public proporty
    var restaurant: Restaurant?
    var selectedArray: Array<YNPorterhouseDish>?
    
    var totalPrice: Float?
    
    var realTotalPrice: Float? {
    
        var temp: Float = 0
        
        if discount > 0 {
            
            temp = totalPrice! - Float(discount)
           
            
        } else {
            
            temp = totalPrice!
            
            
        }
        
        return temp
    }
    
    var isDiscount: Bool {
    
        return discount > 0 ? true : false
    }
    
    var discount: Int {
    
        var temp: Int = 0
        for item in orderForm!.payWay {
        
            if item.selected {
            
                temp += item.discount
                break
            }
        
        }
        
        temp += orderForm!.discount
        return temp
    }
    
    var orderForm: OrderForm? {
   
        didSet {
       
            setupInterface()
            setupLayout()
            setupData()
            
        }
    }
    
    func setupData() {
    
        self.bottomView.discount = discount
        bottomView.price = realTotalPrice
        
    }
    
    
    //MARK: - life cycle 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "订单确认"
        self.view.backgroundColor = UIColor(red: 234/255.0, green: 234/255.0, blue: 234/255.0, alpha: 1)
        
        getData()
    }
    
    func getData() {
   
        let path = NSBundle.mainBundle().pathForResource("preOrder", ofType: "plist")
        
        if let tempPath = path {
            
            let dataDict: NSDictionary = NSDictionary(contentsOfFile: tempPath)!
            
            if let status: Int = dataDict["status"] as? Int{
                
                if status == 1 {
                    
                    let typeArray: NSDictionary = dataDict["data"] as! NSDictionary
                    
                    orderForm = OrderForm(dict: typeArray)
                    
                    
                    } else {
                        
                        YNProgressHUD().showText("该商店暂未上传菜品", toView: self.view)
                    }
                
            }
            
            
        } else {
            
            print("\n --plist文件不存在 --  \n", terminator: "")
        }

        
    }
    
    func setupInterface() {
   
        self.view.addSubview(tableView)
        self.view.addSubview(bottomView)
    }
    
    func setupLayout() {
   
        //tableView
        Layout().addTopConstraint(tableView, toView: self.view, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(tableView, toView: self.view, multiplier: 1, constant: -bottomViewHeight)
        Layout().addLeftConstraint(tableView, toView: self.view, multiplier: 1, constant: 0)
        Layout().addRightConstraint(tableView, toView: self.view, multiplier: 1, constant: 0)
        
        //bottomView
        Layout().addTopToBottomConstraint(bottomView, toView: tableView, multiplier: 1, constant: 0)
        Layout().addLeftConstraint(bottomView, toView: self.view, multiplier: 1, constant: 0)
        Layout().addRightConstraint(bottomView, toView: self.view, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(bottomView, toView: self.view, multiplier: 1, constant: 0)
        
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if isDiscount {
        
           return 4
        }
        
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return orderForm!.payWay.count
        }
        
        if isDiscount {
            
            if section == 3 {
                
                return selectedArray!.count
            }
            
        } else {
        
            if section == 2 {
                
                return selectedArray!.count
            }
        
        }
        
        
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        if indexPath.section == 0 {
//       
//            let identify: String = "CELL_userAddress"
//            var cell: YNOrderFormAddressCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? YNOrderFormAddressCell
//            
//            if cell == nil {
//                
//                cell = YNOrderFormAddressCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
//                
//            }
//
//            return cell!
//        }
        
        if indexPath.section == 0 {
            
            let identify: String = "CELL_pay"
            var cell: YNOrderFormPayCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? YNOrderFormPayCell
            
            if cell == nil {
                
                cell = YNOrderFormPayCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
                
            }
            
            cell?.payWay = orderForm?.payWay[indexPath.row]
            cell?.delegate = self
            return cell!
        }
        if indexPath.section == 1 {
            
            let identify: String = "CELL_remark"
            var cell: YNMealTimeOrOtherCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? YNMealTimeOrOtherCell
            
            if cell == nil {
                
                cell = YNMealTimeOrOtherCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
                
            }
            
            return cell!
        }
        
        if isDiscount {
        
            if indexPath.section == 2 {
                
                let identify: String = "CELL_Compon"
                var cell: YNOrderFormComponCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? YNOrderFormComponCell
                
                if cell == nil {
                    
                    cell = YNOrderFormComponCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
                    
                }
                
                cell?.discount = "-¥\(discount)"
                return cell!
                
            }
            
            
            if indexPath.section == 3 {
                
                let identify: String = "CELL_SelectDish"
                var cell: YNOrderFormSelectDishCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? YNOrderFormSelectDishCell
                
                if cell == nil {
                    
                    cell = YNOrderFormSelectDishCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
                    
                }
                
                cell?.data = self.selectedArray![indexPath.row]
                
                return cell!
            }

        } else {
        
        
            if indexPath.section == 2 {
                
                let identify: String = "CELL_SelectDish"
                var cell: YNOrderFormSelectDishCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? YNOrderFormSelectDishCell
                
                if cell == nil {
                    
                    cell = YNOrderFormSelectDishCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
                    
                }
                
                cell?.data = self.selectedArray![indexPath.row]
                
                return cell!
            }

        }
        
        
        
        let identify: String = "CELL_Address"
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify)
        
        if cell == nil {
       
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
           
        }
        
        cell!.textLabel?.text = "rose"
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//       
//            return 80
//        }
//        
//        if indexPath.section == 3 {
//       
//            if indexPath.row == 1 {
//           
//                return 64
//            }
//            
//        }
        return 44
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 16
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 1
    }
    
    //MARK: - YNOrderFormPayCellDelegate
    func orderFormPayCellSelectedButtonDidClick(cell: YNOrderFormPayCell) {
        
        if cell.payWay!.selected {
       
            let payWayId = cell.payWay!.id
            
            for item in orderForm!.payWay {
                
                let itemId = item.id
                
                if itemId == payWayId {
                    
                    item.selected = cell.payWay!.selected
                    
                } else {
                    
                    item.selected = false
                }
                
            }
            
        }  else {
       
            for item in orderForm!.payWay {
                
                if item.id == cell.payWay!.id {
                    
                    item.selected = cell.payWay!.selected
                    break
                }
                
            }
        }
        
        self.tableView.reloadData()
        
        bottomView.discount = discount
        bottomView.price = realTotalPrice
        
    }
    
    //MAEK: - YNOrderFormBottomViewDelegate
    func orderFormBottomViewDoneButtonDidClick(orderFormBottomView: YNOrderFormBottomView) {
        
        for item in orderForm!.payWay {
            
            if item.selected  {
                
                if item.id! == "1" {//在线支付
                
                    let vertifyVc = YNVertifyOrderViewController()
                    vertifyVc.restaurant = restaurant
                    vertifyVc.totalPrice = realTotalPrice
                    self.navigationController?.pushViewController(vertifyVc, animated: true)
                    
                } else if item.id! == "2" {//到付
                
                
                    let orderSuccessVc = YNOrderSuccessViewController()
                    
                    self.navigationController?.pushViewController(orderSuccessVc, animated: true)
                
                }
                
               break
                
            }
            
        }
        
    
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
    
    private lazy var bottomView: YNOrderFormBottomView = {
   
        let tempView: YNOrderFormBottomView = YNOrderFormBottomView()
        tempView.translatesAutoresizingMaskIntoConstraints = false
        tempView.delegate = self
        return tempView
    }()
    
}
