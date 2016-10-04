//
//  YNPorterhouseOrderView.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/6.
//  Copyright (c) 2015年 农盟. All rights reserved.
//点菜

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


protocol YNPorterhouseOrderViewDelegate {
    
    func porterhouseOrderViewCrollViewScrolledEnable(_ enable: Bool)
    
    func porterhouseOrderViewDoneButtonDidClick(_ controller: YNPorterhouseOrderView, totalPrice: Float)
    
    func porterhouseOrderViewInteractivePopGestureRecognizer(_ enabled: Bool)
}

class YNPorterhouseOrderView: UIView, UITableViewDataSource, UITableViewDelegate, YNDishTableViewCellDelegate, YNCartViewDelegate, PriceViewDelegate, YNOrderTableCellDelegate {

    
    //MARK: - public property
    var delegate: YNPorterhouseOrderViewDelegate?
    
    //父页面topview的高度
    var superViewTopViewHeight: CGFloat = 0 {
   
        didSet {
       
            self.keywindowBgView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 64 + superViewTopViewHeight)
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
        
        typeTableView.frame = CGRect(x: 0, y: 0, width: typeTableViewWidth, height: self.frame.size.height - self.bottomViewHeight)
        dishTableView.frame = CGRect(x: typeTableViewWidth + 8, y: 0, width: dishTableViewWidth, height: self.frame.size.height - self.bottomViewHeight)
        bottomPriceView.frame = CGRect(x: 0, y: dishTableView.frame.maxY, width: self.frame.size.width * 0.63, height: self.bottomViewHeight)
        doneButton.frame = CGRect(x: bottomPriceView.frame.maxX, y: dishTableView.frame.maxY, width: self.frame.size.width * 0.37, height: self.bottomViewHeight)
        
       cartView.frame = CGRect(x: 10 , y: self.frame.size.height - 10 - self.cartViewH, width: self.cartViewW, height: self.cartViewH)
        
    }
    
    func createAJumpImageView() -> UIImageView {
   
        let tempView = UIImageView(image: UIImage(named: "shop_menu_jump_icon"))
        tempView.bounds = CGRect(x: 0, y: 0, width: 16, height: 16)
        return tempView
        
    }
    
    func translateCoorinate(_ view: UIView) {
        
        let jumpImagecenter: CGPoint = view.superview!.convert(view.center, to: self)
        
        let controlPoint: CGPoint = CGPoint(x: jumpImagecenter.x - 220, y: jumpImagecenter.y - 120)
        
        let endPoint = self.cartView.convert(self.cartView.cartBackgroundView.center, to: self)
        
        let jumpView = createAJumpImageView()
        
        jumpView.center = jumpImagecenter
        
        self.addSubview(jumpView)
        
        jumpToCart(jumpView, startPoint: jumpImagecenter, controlPoint: controlPoint, endPoint: endPoint)
        
    }
    
    func jumpToCart(_ view: UIView, startPoint: CGPoint, controlPoint: CGPoint, endPoint: CGPoint) {
        
        //TODO: 动画
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        let path: CGMutablePath = CGMutablePath()
        
        path.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
        path.addQuadCurve(to: CGPoint(x: endPoint.x, y: endPoint.y), control: CGPoint(x: controlPoint.x, y: controlPoint.y))
        
//        CGPathMoveToPoint(path, nil, startPoint.x, startPoint.y)
//        CGPathAddCurveToPoint(path, nil, startPoint.x, startPoint.y, controlPoint.x, controlPoint.y, endPoint.x, endPoint.y)
        
        
        animation.path = path
        
        let duration = 0.55
        animation.duration = duration
        animation.beginTime = 0
        animation.repeatCount = 0
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        view.layer.add(animation, forKey: "position")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(duration * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { () -> Void in
            
            view.removeFromSuperview()
            self.animateCartView()
        }
        
    }
    
    func animateCartView() {
   
        let animation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1.2, 0.7, 1]
        animation.keyTimes = [0, 0.4, 0.6, 0.3]
        animation.beginTime = 0
        animation.repeatCount = 0
        animation.isRemovedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
    
        self.cartView.layer.add(animation, forKey: "position")
        
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView.tag == 2 {
       
            return 119
        } else if tableView.tag == 1 {
       
            return 50
        }
    
        return orderTableCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 1 {
       
            let identify: String = "CELL_TYPE"
            var cell: YNTypeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identify) as? YNTypeTableViewCell
            if cell == nil {
           
                cell = YNTypeTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identify)
            }
            
            cell?.data = self.data![(indexPath as NSIndexPath).row]
          
            return cell!
            
        } else if tableView.tag == 2 {
            
            let identify: String = "CELL_Dish"
            
            var cell:YNDishTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identify) as?  YNDishTableViewCell
            if cell == nil {
                
                cell = YNDishTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identify)
            }
            
            let temptype: YNPorthouseType = self.data![typeSelectedIndex]
            
            cell?.data = temptype.dataArray[(indexPath as NSIndexPath).row]
            
            cell?.delegate = self
            
            return cell!
            
        } else if tableView.tag == 3 {
       
            let identify: String = "CELL_ORDER"
            
            var cell: YNOrderTableCell? = tableView.dequeueReusableCell(withIdentifier: identify) as? YNOrderTableCell
            
            if cell == nil {
                
                cell = YNOrderTableCell(style: UITableViewCellStyle.default, reuseIdentifier: identify)
            }
            
            if selectedArray?.count > 0 {
                
                cell?.data = selectedArray![(indexPath as NSIndexPath).row]
                cell?.delegate = self
            }
            
            return cell!
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if tableView.tag == 3 {
       
            return orderTableHeaderHeight
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView.tag == 3 {
            
            let header: YnOrderTableHeaderView = YnOrderTableHeaderView()
            
            return header
        }

        return nil
    }
    
    //MARK: - UITableViewDelagate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.tag == 1 {
            
            self.data![self.typeSelectedIndex].selected = false
            
            let type: YNPorthouseType = self.data![(indexPath as NSIndexPath).row]
            type.selected = true
            
            self.typeSelectedIndex = (indexPath as NSIndexPath).row
            
            self.typeTableView.reloadData()
            self.dishTableView.reloadData()
        }
        
    }

    //MARK: - YNDishTableViewCellDelegate
    func dishTableViewCellAddButtonDidClick(_ cell: YNDishTableViewCell, button: UIButton) {
        
        translateCoorinate(button)
        
        let type: YNPorthouseType = self.data![self.typeSelectedIndex]
        
        type.selectedNumber += 1
        self.typeTableView.reloadData()
        
        //处理下面的购物篮数量
        self.cartView.selectedNumber += 1
        
        //确定按钮的处理
        if self.cartView.selectedNumber > 0{
            
            self.doneButton.backgroundColor = kStyleColor
            self.doneButton.isUserInteractionEnabled = true
        } else {
            
            self.doneButton.backgroundColor = UIColor.gray
            self.doneButton.isUserInteractionEnabled = false
        }
        
        //总价格
        if let price = cell.data!.price {
            
            self.bottomPriceView.totalPrice += price
        }

    }
    
    func dishTableViewCellMinusButtonDidClick(_ cell: YNDishTableViewCell) {
        
        let type: YNPorthouseType = self.data![self.typeSelectedIndex]
        
        type.selectedNumber -= 1
        self.typeTableView.reloadData()
        
        //处理下面的购物篮数量
         self.cartView.selectedNumber -= 1
        
         //确定按钮的处理
        if self.cartView.selectedNumber > 0{
       
            self.doneButton.backgroundColor = kStyleColor
            self.doneButton.isUserInteractionEnabled = true
        } else {
       
            self.doneButton.backgroundColor = UIColor.gray
            self.doneButton.isUserInteractionEnabled = false
        }
        
        //总价格
        if let price = cell.data!.price {
            
            self.bottomPriceView.totalPrice -= price
        }
        
    }
    
    //MARK: YNOrderTableCellDelegate
    
    func orderTableCellAddButtonDidClick(_ cell: YNOrderTableCell) {
        
        let type: YNPorthouseType = self.data![cell.data!.firstIndex]
        type.selectedNumber += 1
        
          //处理下面的购物篮数量
        self.cartView.selectedNumber += 1
        self.typeTableView.reloadData()
        self.dishTableView.reloadData()
        //总价格
        if let price = cell.data!.price {
            
            self.bottomPriceView.totalPrice += price
        }
        
    }
    
    func orderTableCellMinusButtonDidClick(_ cell: YNOrderTableCell) {
        
        let type: YNPorthouseType = self.data![cell.data!.firstIndex]
        type.selectedNumber -= 1
        
          //处理下面的购物篮数量
        self.cartView.selectedNumber -= 1
        
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
    func cartViewDidClick(_ view: YNCartView) {
        
        cartViewOrPriceViewClick(view)
        
    }
    //MARK: - PriceViewDelegate
    func priceViewDidClick(_ view: PriceView) {
        
        cartViewOrPriceViewClick(view)
        
    }
    
    func cartViewOrPriceViewClick(_ view: UIView) {
        
        if let _ = selectedArray {
            
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
    
    func setOrderTabelView(_ isframe: Bool) {
   
        self.addSubview(orderTableView)
        orderTableView.reloadData()
        
        if isframe {
       
            self.orderTableView.frame = CGRect(x: 0, y: self.orderTableViewY, width: kScreenWidth, height: self.orderTableViewHeight)
            
            if self.orderTableViewHeight == orderTableHeaderHeight {
           
                isShowOrderView = false
                keywindowBgView.removeFromSuperview()
                orderBgView.removeFromSuperview()
                orderTableView.removeFromSuperview()
                self.doneButton.backgroundColor = UIColor.gray
            }
        }
        
        self.insertSubview(bottomPriceView, aboveSubview: orderTableView)
        self.insertSubview(doneButton, aboveSubview: orderTableView)
        self.insertSubview(cartView, aboveSubview: bottomPriceView)
    }
    
    func showOrderView() {
        
        self.delegate?.porterhouseOrderViewInteractivePopGestureRecognizer(false)

        
        //设置orderTable的位置
        setOrderTabelView(false)
        
        //设置背景蒙板
        setBgView()
    
        
        //通知父视图scrollView不能滚动
        self.delegate?.porterhouseOrderViewCrollViewScrolledEnable(false)
        
        UIView.animate(withDuration: self.animateDuration, animations: { () -> Void in
            
            self.keywindowBgView.alpha = 1
            self.orderBgView.alpha = 1
            self.orderTableView.frame = CGRect(x: 0, y: self.orderTableViewY, width: kScreenWidth, height: self.orderTableViewHeight)
    
        }, completion: { (finished) -> Void in
            
        }) 
        
    }
    
    func hideOrderView() {
        
        UIView.animate(withDuration: self.animateDuration, animations: { () -> Void in
            
            self.orderTableView.frame = CGRect(x: 0, y: kScreenHeight - self.bottomViewHeight, width: kScreenWidth, height: 0)
            self.keywindowBgView.alpha = 0
            self.orderBgView.alpha = 0
            
            self.isShowOrderView = false
            
        }, completion: { (finish) -> Void in
            
            self.keywindowBgView.removeFromSuperview()
            self.orderBgView.removeFromSuperview()
            self.orderTableView.removeFromSuperview()
            
            self.delegate?.porterhouseOrderViewCrollViewScrolledEnable(true)
            
            self.delegate?.porterhouseOrderViewInteractivePopGestureRecognizer(true)
        }) 
        
        
    }
    
    func setBgView() {
   
        let tgr: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(YNPorterhouseOrderView.viewDidClick))
        keywindowBgView.addGestureRecognizer(tgr)
        orderBgView.addGestureRecognizer(tgr)
        
        //自己view上的蒙板
        orderBgView.frame = self.bounds
        self.addSubview(orderBgView)
        
        //window 上的蒙板 这样看起来才像一个完整的蒙板
        keywindowBgView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 64 + self.superViewTopViewHeight)
        let window = UIApplication.shared.keyWindow!
        window.addSubview(keywindowBgView)
        
        self.insertSubview(orderBgView, belowSubview: orderTableView)
    }
    
    func viewDidClick() {
        
        isShowOrderView = false
        hideOrderView()
    }
    
    //MARK: - event response
    func doneButtonDidClick() {
   
        if let _ = orderTableView.superview {
       
            hideOrderView()
        }
        
        self.delegate?.porterhouseOrderViewDoneButtonDidClick(self, totalPrice: bottomPriceView.totalPrice)
    }
    
    //MARK: - private property
    fileprivate let bottomViewHeight: CGFloat = 50
    fileprivate var typeSelectedIndex: Int = 0
    fileprivate let cartViewH: CGFloat = 55
    fileprivate let cartViewW: CGFloat = 56
    fileprivate let animateDuration: TimeInterval = 0.5
    fileprivate var isShowOrderView: Bool = false
    
    fileprivate let orderTableHeaderHeight: CGFloat = 36
    fileprivate let orderTableCellHeight: CGFloat = 48
    fileprivate var maxNumberOrderTableCell:Int {
   
        get {
       
            if kIS_iPhone6() || kIS_iPhone6Plus() {
           
                return 8
            }
            
            return 6
        }
    }
    
    
    fileprivate var orderTableViewY: CGFloat {
   
        get {
            let viewY = self.frame.size.height - bottomViewHeight - orderTableViewHeight
            
            return viewY
        }
        
    }
    fileprivate var orderTableViewHeight: CGFloat {
   
        get {
       
            let exceedsTheMaximumNumber: Bool = self.selectedArray!.count >= self.maxNumberOrderTableCell
            let maxHeight: CGFloat = CGFloat(maxNumberOrderTableCell)*orderTableCellHeight
            let normalHeight: CGFloat = CGFloat(self.selectedArray!.count) * self.orderTableCellHeight
            let cellHeight =  exceedsTheMaximumNumber ? maxHeight : normalHeight
    
            let viewHeight = cellHeight + self.orderTableHeaderHeight
            
            return viewHeight
        }
    }
    
    fileprivate lazy var typeTableView: UITableView = {
        
        var tempTableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.tag = 1
        tempTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tempTableView.backgroundColor = UIColor(red: 234/255.0, green: 234/255.0, blue: 234/255.0, alpha: 1)
        return tempTableView
        
        }()
    
    fileprivate lazy var dishTableView: UITableView = {
        
        var tempTableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tempTableView.tag = 2
        return tempTableView
        
        }()

    fileprivate lazy var bottomPriceView: PriceView = {
        
        var tempView = PriceView()
        
        tempView.delegate = self
        
        return tempView
        
        }()
    
    fileprivate lazy var doneButton: UIButton = {
        
        var tempView: UIButton = UIButton()
        tempView.backgroundColor = UIColor.gray
        tempView.setTitle("选好了", for: UIControlState())
        tempView.addTarget(self, action: #selector(YNPorterhouseOrderView.doneButtonDidClick), for: UIControlEvents.touchUpInside)
        tempView.isUserInteractionEnabled = false
        return tempView
        
        }()
    
    fileprivate lazy var cartView: YNCartView = {
        
        var tempView = YNCartView()
        
        tempView.delegate = self
        
        return tempView
        
        }()
    
    fileprivate lazy var orderTableView: UITableView = {
        
        var tempTableView = UITableView(frame: CGRect(x: 0, y: kScreenHeight - self.bottomViewHeight, width: kScreenWidth, height: 0), style: UITableViewStyle.plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.tag = 3
        //iOS7使用frame的时候一定不要加这个
//        tempTableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        tempTableView.bounces = false
        return tempTableView
        
        }()
    
    fileprivate lazy var keywindowBgView: UIView = {
   
        var tempView: UIView = UIView()
        tempView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        tempView.tag = 100
        tempView.alpha = 0
        return tempView
    }()
    
    fileprivate lazy var orderBgView: UIView = {
        
        var tempView = UIView()
        tempView.alpha = 0
        tempView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        return tempView
        }()
    
    
}

