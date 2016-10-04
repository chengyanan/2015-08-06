//
//  progressHUD.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/11.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import Foundation
import UIKit

 enum ProgressHUDMode: Int {
    
    case text
    case indicator
}


struct YNProgressHUD {
    
    internal func showText(_ text: String, toView: UIView) {
        
        let progressHUD = ProgressHUD.showHudToView(toView)
        progressHUD.mode = ProgressHUDMode.text
        progressHUD.text = text
    }
    
    internal func showWaitingToView(_ toView: UIView) -> ProgressHUD{
        
        let hud = ProgressHUD(frame: CGRect(x: toView.center.x-50, y: toView.center.y-50, width: 80, height: 80))
        hud.mode = ProgressHUDMode.indicator
        toView.addSubview(hud)
        return hud
    }
}


class ProgressHUD: UIView {
    
    let textMaxWidth = kScreenWidth * 0.8
    let textmaxHeight: CGFloat = 50
    let margin: CGFloat = 30
    let kFont = UIFont.boldSystemFont(ofSize: 16)
    let kCornerRadius: CGFloat = 10
    let kBackgroundColor = kRGBA(0, g: 0, b: 0, a: 0.9)
    
    var timer: Timer?
    var textRealWidth: CGFloat?
    var mode: ProgressHUDMode? {
   
        didSet {
       
            if mode == ProgressHUDMode.indicator {
           
                setUpInterface()
            }
        }
    }
    var text: String? {
        
        didSet {
            
            setUpInterface()
        }
    }
    
    fileprivate lazy var textLabel: UILabel! = {
        
        var label = UILabel()
        label.textColor = UIColor.white
        label.layer.cornerRadius = self.kCornerRadius
        label.clipsToBounds = true
        label.bounds = CGRect(x: 0, y: 0, width: self.textMaxWidth, height: self.textmaxHeight)
        label.backgroundColor = self.kBackgroundColor
        label.textAlignment = NSTextAlignment.center
        
        label.font = self.kFont
        label.text = self.text
        label.sizeToFit()
        
        self.textRealWidth = min(label.frame.size.width, self.textMaxWidth) + self.margin
        label.bounds = CGRect(x: 0, y: 0, width: self.textRealWidth!, height: self.textmaxHeight)
        label.center = self.center
        
        return label
        
        }()
    
    fileprivate lazy var indicator: UIActivityIndicatorView! = {
        
        var tempIndication = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        tempIndication.center = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height/2)
        tempIndication.transform = CGAffineTransform(a: 1.6, b: 0, c: 0, d: 1.6, tx: 0, ty: 0)
        tempIndication.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
//       print(NSStringFromCGPoint(tempIndication.center))
        
        tempIndication.startAnimating()
        return tempIndication
        
        }()
    
   class func showHudToView(_ view: UIView) ->ProgressHUD{
   
    let hud:ProgressHUD = ProgressHUD(frame: view.bounds)
    
    view.addSubview(hud)
    
    return hud

    }
    
//MARK: custom method
    func setUpInterface() {
   
        if mode == ProgressHUDMode.text {
       
            self.addSubview(textLabel)
            showUsingAnimation(true)
        
        } else if mode == ProgressHUDMode.indicator {
            
            self.backgroundColor = kRGBA(0, g: 0, b: 0, a: 0.7)
            self.layer.cornerRadius = 12
            self.clipsToBounds = true
            self.addSubview(indicator)
            showUsingAnimation(false)
            
        }
    }
    
    func showUsingAnimation(_ animation: Bool) {
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
        
            self.alpha = 1
        
        }, completion: { (Bool) -> Void in
        
            if animation {
           
                let delay: Double = Double(min(self.textRealWidth!, self.textMaxWidth).native/174.0 * 1)
                let realDelay = max(delay, 1)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(realDelay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: { () -> Void in
                    
                    self.hideUsingAnimation()
                })
            }
            
        }) 
        
    }
    
    func hideUsingAnimation() {
   
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.alpha = 0
        }, completion: { (Bool) -> Void in
            
            self.removeFromSuperview()
        }) 
        
    }
    
// MARK: lift cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        self.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
}
