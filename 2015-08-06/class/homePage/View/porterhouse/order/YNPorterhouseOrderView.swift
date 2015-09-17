//
//  YNPorterhouseOrderView.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/6.
//  Copyright (c) 2015年 农盟. All rights reserved.
//点菜

import UIKit

protocol YNPorterhouseOrderViewDelegate {
    
    func porterhouseOrderViewCrollViewScrolledEnable(enable: Bool)
    
    func porterhouseOrderViewDoneButtonDidClick()
}

class YNPorterhouseOrderView: UIView, UITableViewDataSource, UITableViewDelegate, YNDishTableViewCellDelegate, YNCartViewDelegate, PriceViewDelegate, YNOrderTableCellDelegate {

    
    //MARK: - public property
    var delegate: YNPorterhouseOrderViewDelegate?
    
    //父页面topview的高度
    var superViewTopViewHeight: CGFloat = 0 {
   
        didSet {
       
            self.keywindowBgView.frame = CGRectMake(0, 0, kScreenWidth, 64 + superViewTopViewHeight)
        }
    }
    
    var data: Array<YNPorthouseType>? {
   
        didSet {
       
            if data?.count > 0 {
           
                self.setupInterface()
            }
            
        }
    }
    
    var selectedArray: Array<YNPorterhouseDish>? {
   
        get {
       
            var tempArray = [YNPorterhouseDish]()
            
            for item:YNPorthouseType in data! {
           
                for dish:YNPorterhouseDish in item.dataArray {
               
                    if dish.number > 0 {
                   
                        tempArray.append(dish)
                    }
                }
            }
            
            return tempArray
        }
    }
    
    
    
    //MARK: - private method 
    func setupInterface() {
   
        self.addSubview(typeTableView)
        self.addSubview(dishTableView)
        
        self.addSubview(bottomPriceView)
        self.addSubview(doneButton)
        self.addSubview(cartView)
        
        let typeTableViewWidth = self.frame.size.width * 0.3
        let dishTableViewWidth = self.frame.size.width - (typeTableViewWidth + 8)
        
        typeTableView.frame = CGRectMake(0, 0, typeTableViewWidth, self.frame.size.height - self.bottomViewHeight)
        dishTableView.frame = CGRectMake(typeTableViewWidth + 8, 0, dishTableViewWidth, self.frame.size.height - self.bottomViewHeight)
        bottomPriceView.frame = CGRectMake(0, CGRectGetMaxY(dishTableView.frame), self.frame.size.width * 0.63, self.bottomViewHeight)
        doneButton.frame = CGRectMake(CGRectGetMaxX(bottomPriceView.frame), CGRectGetMaxY(dishTableView.frame), self.frame.size.width * 0.37, self.bottomViewHeight)
        
       cartView.frame = CGRectMake(10 , self.frame.size.height - 10 - self.cartViewH, self.cartViewW, self.cartViewH)
        
    }
    
    func createAJumpImageView() -> UIImageView {
   
        var tempView = UIImageView(image: UIImage(named: "shop_menu_jump_icon"))
        tempView.bounds = CGRectMake(0, 0, 16, 16)
        return tempView
        
    }
    
    func translateCoorinate(view: UIView) {
        
        let jumpImagecenter: CGPoint = view.superview!.convertPoint(view.center, toView: self)
        
        let controlPoint: CGPoint = CGPointMake(jumpImagecenter.x - 220, jumpImagecenter.y - 120)
        
        let endPoint = self.cartView.convertPoint(self.cartView.cartBackgroundView.center, toView: self)
        
        var jumpView = createAJumpImageView()
        
        jumpView.center = jumpImagecenter
        
        self.addSubview(jumpView)
        
        jumpToCart(jumpView, startPoint: jumpImagecenter, controlPoint: controlPoint, endPoint: endPoint)
        
    }
    
    func jumpToCart(view: UIView, startPoint: CGPoint, controlPoint: CGPoint, endPoint: CGPoint) {
        
        //TODO: 动画
        var animation = CAKeyframeAnimation(keyPath: "position")
        
        var path: CGMutablePathRef = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, startPoint.x, startPoint.y)
        CGPathAddCurveToPoint(path, nil, startPoint.x, startPoint.y, controlPoint.x, controlPoint.y, endPoint.x, endPoint.y)
        animation.path = path
        
        let duration = 0.55
        animation.duration = duration
        animation.beginTime = 0
        animation.repeatCount = 0
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        view.layer.addAnimation(animation, forKey: "position")
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(duration * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            
            view.removeFromSuperview()
            self.animateCartView()
        }
        
    }
    
    func animateCartView() {
   
        var animation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1.2, 0.7, 1]
        animation.keyTimes = [0, 0.4, 0.6, 0.3]
        animation.beginTime = 0
        animation.repeatCount = 0
        animation.removedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
    
        self.cartView.layer.addAnimation(animation, forKey: "position")
        
    }
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if tableView.tag == 1 {
       
            if let tempData = self.data {
           
                return tempData.count
            }
            
        } else if tableView.tag == 2 {
            
            if let tempData = self.data {
                
                let type: YNPorthouseType = tempData[typeSelectedIndex]
                
                return type.dataArray.count
            }
            
        }else if tableView.tag == 3 {
            
            if selectedArray?.count > 0 {
                
                return selectedArray!.count
            }
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if tableView.tag == 2 {
       
            return 119
        } else if tableView.tag == 1 {
       
            return 50
        }
    
        return orderTableCellHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView.tag == 1 {
       
            let identify: String = "CELL_TYPE"
            var cell: YNTypeTableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? YNTypeTableViewCell
            if cell == nil {
           
                cell = YNTypeTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
            }
            
            cell?.data = self.data![indexPath.row]
          
            return cell!
            
        } else if tableView.tag == 2 {
            
            let identify: String = "CELL_Dish"
            
            var cell:YNDishTableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify) as?  YNDishTableViewCell
            if cell == nil {
                
                cell = YNDishTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
            }
            
            let temptype: YNPorthouseType = self.data![typeSelectedIndex]
            
            cell?.data = temptype.dataArray[indexPath.row]
            
            cell?.delegate = self
            
            return cell!
            
        } else if tableView.tag == 3 {
       
            let identify: String = "CELL_ORDER"
            
            var cell: YNOrderTableCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? YNOrderTableCell
            
            if cell == nil {
                
                cell = YNOrderTableCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
            }
            
            if selectedArray?.count > 0 {
                
                cell?.data = selectedArray![indexPath.row]
                cell?.delegate = self
            }
            
            return cell!
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if tableView.tag == 3 {
       
            return orderTableHeaderHeight
        }
        
        return 0
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView.tag == 3 {
            
            var header: YnOrderTableHeaderView = YnOrderTableHeaderView()
            
            return header
        }

        return nil
    }
    
    //MARK: - UITableViewDelagate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView.tag == 1 {
            
            self.data![self.typeSelectedIndex].selected = false
            
            var type: YNPorthouseType = self.data![indexPath.row]
            type.selected = true
            
            self.typeSelectedIndex = indexPath.row
            
            self.typeTableView.reloadData()
            self.dishTableView.reloadData()
        }
        
    }

    //MARK: - YNDishTableViewCellDelegate
    func dishTableViewCellAddButtonDidClick(cell: YNDishTableViewCell, button: UIButton) {
        
        translateCoorinate(button)
        
        var type: YNPorthouseType = self.data![self.typeSelectedIndex]
        
        type.selectedNumber++
        self.typeTableView.reloadData()
        
        //处理下面的购物篮数量
        self.cartView.selectedNumber++
        
        //确定按钮的处理
        if self.cartView.selectedNumber > 0{
            
            self.doneButton.backgroundColor = kStyleColor
            self.doneButton.userInteractionEnabled = true
        } else {
            
            self.doneButton.backgroundColor = UIColor.grayColor()
            self.doneButton.userInteractionEnabled = false
        }
        
        //总价格
        if let price = cell.data!.price {
            
            self.bottomPriceView.totalPrice += price
        }

    }
    
    func dishTableViewCellMinusButtonDidClick(cell: YNDishTableViewCell) {
        
        var type: YNPorthouseType = self.data![self.typeSelectedIndex]
        
        type.selectedNumber--
        self.typeTableView.reloadData()
        
        //处理下面的购物篮数量
         self.cartView.selectedNumber--
        
         //确定按钮的处理
        if self.cartView.selectedNumber > 0{
       
            self.doneButton.backgroundColor = kStyleColor
            self.doneButton.userInteractionEnabled = true
        } else {
       
            self.doneButton.backgroundColor = UIColor.grayColor()
            self.doneButton.userInteractionEnabled = false
        }
        
        //总价格
        if let price = cell.data!.price {
            
            self.bottomPriceView.totalPrice -= price
        }
        
    }
    
    //MARK: YNOrderTableCellDelegate
    
    func orderTableCellAddButtonDidClick(cell: YNOrderTableCell) {
        
        var type: YNPorthouseType = self.data![cell.data!.firstIndex]
        type.selectedNumber++
        
          //处理下面的购物篮数量
        self.cartView.selectedNumber++
        self.typeTableView.reloadData()
        self.dishTableView.reloadData()
        //总价格
        if let price = cell.data!.price {
            
            self.bottomPriceView.totalPrice += price
        }
        
    }
    
    func orderTableCellMinusButtonDidClick(cell: YNOrderTableCell) {
        
        var type: YNPorthouseType = self.data![cell.data!.firstIndex]
        type.selectedNumber--
        
          //处理下面的购物篮数量
        self.cartView.selectedNumber--
        
        self.typeTableView.reloadData()
        self.dishTableView.reloadData()
        //总价格
        if let price = cell.data!.price {
            
            self.bottomPriceView.totalPrice -= price
        }
        
        
        if cell.data?.number <= 0 {
            
            
            setOrderTabelView(true)
            
            self.delegate?.porterhouseOrderViewCrollViewScrolledEnable(true)
        }
        
       
    }
    //MARK: - YNCartViewDelegate
    func cartViewDidClick(view: YNCartView) {
        
        cartViewOrPriceViewClick(view)
        
    }
    //MARK: - PriceViewDelegate
    func priceViewDidClick(view: PriceView) {
        
        cartViewOrPriceViewClick(view)
        
    }
    
    func cartViewOrPriceViewClick(view: UIView) {
        
        if let tempDataArray = selectedArray {
            
            if selectedArray!.count > 0 {
                
                isShowOrderView = !isShowOrderView
                               
                if isShowOrderView {
                    
                    showOrderView()
                    
                } else {
                    
                    hideOrderView()
                }
            }
            
        }
        
    }
    
    func setOrderTabelView(isframe: Bool) {
   
        self.addSubview(orderTableView)
        orderTableView.reloadData()
        
        if isframe {
       
            self.orderTableView.frame = CGRectMake(0, self.orderTableViewY, kScreenWidth, self.orderTableViewHeight)
            
            if self.orderTableViewHeight == orderTableHeaderHeight {
           
                isShowOrderView = false
                keywindowBgView.removeFromSuperview()
                orderBgView.removeFromSuperview()
                orderTableView.removeFromSuperview()
                self.doneButton.backgroundColor = UIColor.grayColor()
            }
        }
        
        self.insertSubview(bottomPriceView, aboveSubview: orderTableView)
        self.insertSubview(doneButton, aboveSubview: orderTableView)
        self.insertSubview(cartView, aboveSubview: bottomPriceView)
    }
    
    func showOrderView() {
        
        //设置orderTable的位置
        setOrderTabelView(false)
        
        //设置背景蒙板
        setBgView()
    
        //通知父视图scrollView不能滚动
        self.delegate?.porterhouseOrderViewCrollViewScrolledEnable(false)
        
        UIView.animateWithDuration(self.animateDuration, animations: { () -> Void in
            
            self.keywindowBgView.alpha = 1
            self.orderBgView.alpha = 1
            self.orderTableView.frame = CGRectMake(0, self.orderTableViewY, kScreenWidth, self.orderTableViewHeight)
    
        }) { (finished) -> Void in
            
            
        }
        
    }
    
    func hideOrderView() {
        
        UIView.animateWithDuration(self.animateDuration, animations: { () -> Void in
            
            self.orderTableView.frame = CGRectMake(0, kScreenHeight - self.bottomViewHeight, kScreenWidth, 0)
            self.keywindowBgView.alpha = 0
            self.orderBgView.alpha = 0
            
            self.isShowOrderView = false
            
        }) { (finish) -> Void in
            
            self.keywindowBgView.removeFromSuperview()
            self.orderBgView.removeFromSuperview()
            self.orderTableView.removeFromSuperview()
        }
        
        self.delegate?.porterhouseOrderViewCrollViewScrolledEnable(true)
    }
    
    func setBgView() {
   
        var tgr: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "viewDidClick")
        keywindowBgView.addGestureRecognizer(tgr)
        orderBgView.addGestureRecognizer(tgr)
        
        //自己view上的蒙板
        orderBgView.frame = self.bounds
        self.addSubview(orderBgView)
        
        //window 上的蒙板 这样看起来才像一个完整的蒙板
        keywindowBgView.frame = CGRectMake(0, 0, kScreenWidth, 64 + self.superViewTopViewHeight)
        var window = UIApplication.sharedApplication().keyWindow!
        window.addSubview(keywindowBgView)
        
        self.insertSubview(orderBgView, belowSubview: orderTableView)
    }
    
    func viewDidClick() {
        
        isShowOrderView = false
        hideOrderView()
    }
    
    //MARK: - event response
    func doneButtonDidClick() {
   
        if let superView = orderTableView.superview {
       
            hideOrderView()
        }
        
        self.delegate?.porterhouseOrderViewDoneButtonDidClick()
    }
    
    //MARK: - private property
    private let bottomViewHeight: CGFloat = 50
    private var typeSelectedIndex: Int = 0
    private let cartViewH: CGFloat = 55
    private let cartViewW: CGFloat = 56
    private let animateDuration: NSTimeInterval = 0.5
    private var isShowOrderView: Bool = false
    
    private let orderTableHeaderHeight: CGFloat = 36
    private let orderTableCellHeight: CGFloat = 48
    private var maxNumberOrderTableCell:Int {
   
        get {
       
            if kIS_iPhone6() || kIS_iPhone6Plus() {
           
                return 8
            }
            
            return 6
        }
    }
    
    
    private var orderTableViewY: CGFloat {
   
        get {
            let viewY = self.frame.size.height - bottomViewHeight - orderTableViewHeight
            
            return viewY
        }
        
    }
    private var orderTableViewHeight: CGFloat {
   
        get {
       
            let exceedsTheMaximumNumber: Bool = self.selectedArray!.count >= self.maxNumberOrderTableCell
            let maxHeight: CGFloat = CGFloat(maxNumberOrderTableCell)*orderTableCellHeight
            let normalHeight: CGFloat = CGFloat(self.selectedArray!.count) * self.orderTableCellHeight
            let cellHeight =  exceedsTheMaximumNumber ? maxHeight : normalHeight
    
            let viewHeight = cellHeight + self.orderTableHeaderHeight
            
            return viewHeight
        }
    }
    
    private lazy var typeTableView: UITableView = {
        
        var tempTableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.tag = 1
        tempTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tempTableView.backgroundColor = UIColor(red: 234/255.0, green: 234/255.0, blue: 234/255.0, alpha: 1)
        return tempTableView
        
        }()
    
    private lazy var dishTableView: UITableView = {
        
        var tempTableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tempTableView.tag = 2
        return tempTableView
        
        }()

    private lazy var bottomPriceView: PriceView = {
        
        var tempView = PriceView()
        
        tempView.delegate = self
        
        return tempView
        
        }()
    
    private lazy var doneButton: UIButton = {
        
        var tempView: UIButton = UIButton()
        tempView.backgroundColor = UIColor.grayColor()
        tempView.setTitle("选好了", forState: UIControlState.Normal)
        tempView.addTarget(self, action: "doneButtonDidClick", forControlEvents: UIControlEvents.TouchUpInside)
        tempView.userInteractionEnabled = false
        return tempView
        
        }()
    
    private lazy var cartView: YNCartView = {
        
        var tempView = YNCartView()
        
        tempView.delegate = self
        
        return tempView
        
        }()
    
    private lazy var orderTableView: UITableView = {
        
        var tempTableView = UITableView(frame: CGRectMake(0, kScreenHeight - self.bottomViewHeight, kScreenWidth, 0), style: UITableViewStyle.Plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.tag = 3
        //iOS7使用frame的时候一定不要加这个
//        tempTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        tempTableView.bounces = false
        return tempTableView
        
        }()
    
    private lazy var keywindowBgView: UIView = {
   
        var tempView = UIView()
        tempView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        tempView.tag = 100
        tempView.alpha = 0
        return tempView
    }()
    
    private lazy var orderBgView: UIView = {
        
        var tempView = UIView()
        tempView.alpha = 0
        tempView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        return tempView
        }()
    
    
}

