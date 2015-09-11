//
//  YNPorterhouseOrderView.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/6.
//  Copyright (c) 2015年 农盟. All rights reserved.
//点菜

import UIKit

class YNPorterhouseOrderView: UIView, UITableViewDataSource, UITableViewDelegate, YNDishTableViewCellDelegate {

    
    //MARK: - public property
    
    var data: Array<YNPorthouseType>? {
   
        didSet {
       
            if data?.count > 0 {
           
                self.setupInterface()
            }
            
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
    
    //MARK: AnimationDelagete
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        if anim is CAKeyframeAnimation {
            
            if let view = self.tempView {
           
                self.tempView?.removeFromSuperview()
                self.tempView = nil
            }
            
        }
    }
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if let tempData = self.data {
            
            if tableView.tag == 1 {
                
                return tempData.count
                
            } else if tableView.tag == 2 {
           
                let type: YNPorthouseType = tempData[typeSelectedIndex]
                
                return type.dataArray.count
            }
            
        } else {
            
            print("\n ---YNPorterhouseOrderView- 106- 数据为nil \n")
            
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if tableView.tag == 2 {
       
            return 119
        }
        
        return 50
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
            
        }
        
        return UITableViewCell()
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
    
    //MARK: - private property
    private let bottomViewHeight: CGFloat = 50
    private var typeSelectedIndex: Int = 0
    private let cartViewH: CGFloat = 55
    private let cartViewW: CGFloat = 56
    
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
        return tempView
        
        }()
    
    private lazy var doneButton: UIButton = {
        
        var tempView: UIButton = UIButton()
        tempView.backgroundColor = UIColor.grayColor()
        tempView.setTitle("选好了", forState: UIControlState.Normal)
        tempView.userInteractionEnabled = false
        return tempView
        
        }()
    
    private lazy var cartView: YNCartView = {
        
        var tempView = YNCartView()
        
        return tempView
        
        }()
    
    private var tempView: UIView?
}

