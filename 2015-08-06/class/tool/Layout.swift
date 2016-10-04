//
//  Layout.swift
//  2015-08-06
//
//  Created by 农盟 on 15/9/1.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import Foundation
import UIKit

struct Layout {
    
    func addTopConstraint(_ view: UIView, toView: UIView, multiplier:CGFloat, constant: CGFloat) {
   
        let distanceLabelConstantTop = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.top, multiplier: multiplier, constant: constant)
        
        view.superview?.addConstraint(distanceLabelConstantTop)
        
    }
    
    func addLeftConstraint(_ view: UIView, toView: UIView, multiplier:CGFloat, constant: CGFloat) {
        
        let distanceLabelConstantLeft = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.left, multiplier: multiplier, constant: constant)
        
        view.superview?.addConstraint(distanceLabelConstantLeft)
        
    }
    
    func addBottomConstraint(_ view: UIView, toView: UIView, multiplier:CGFloat, constant: CGFloat) {
        
        let distanceLabelConstantLeft = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.bottom, multiplier: multiplier, constant: constant)
        
        view.superview?.addConstraint(distanceLabelConstantLeft)
        
    }
    
    func addRightConstraint(_ view: UIView, toView: UIView, multiplier:CGFloat, constant: CGFloat) {
        
        let distanceLabelConstantLeft = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.right, multiplier: multiplier, constant: constant)
        
        view.superview?.addConstraint(distanceLabelConstantLeft)
        
    }
    
    func addHeightConstraint(_ view: UIView, toView: UIView?, multiplier:CGFloat, constant: CGFloat) {
        
        let distanceLabelConstantHeight = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.height, multiplier: multiplier, constant: constant)
        
        view.superview?.addConstraint(distanceLabelConstantHeight)
        
    }
    
    func addWidthConstraint(_ view: UIView, toView: UIView?, multiplier:CGFloat, constant: CGFloat) {
        
        let distanceLabelConstantHeight = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.width, multiplier: multiplier, constant: constant)
        
        view.superview?.addConstraint(distanceLabelConstantHeight)
        
    }
    
    func addLeftToRightConstraint(_ view: UIView, toView: UIView, multiplier:CGFloat, constant: CGFloat) {
        
        let distanceLabelConstantHeight = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.right, multiplier: multiplier, constant: constant)
        
        view.superview?.addConstraint(distanceLabelConstantHeight)
        
    }

    func addRightToLeftConstraint(_ view: UIView, toView: UIView, multiplier:CGFloat, constant: CGFloat) {
        
        let distanceLabelConstantHeight = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.left, multiplier: multiplier, constant: constant)
        
        view.superview?.addConstraint(distanceLabelConstantHeight)
        
    }

    
    func addTopToBottomConstraint(_ view: UIView, toView: UIView, multiplier:CGFloat, constant: CGFloat) {
        
        let distanceLabelConstantHeight = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.bottom, multiplier: multiplier, constant: constant)
        
        view.superview?.addConstraint(distanceLabelConstantHeight)
        
    }
    
    func addCenterXConstraint(_ view: UIView, toView: UIView, multiplier:CGFloat, constant: CGFloat) {
   
        let distanceLabelConstantHeight = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.centerX, multiplier: multiplier, constant: constant)
        
        view.superview?.addConstraint(distanceLabelConstantHeight)
    }
    
    func addCenterYConstraint(_ view: UIView, toView: UIView, multiplier:CGFloat, constant: CGFloat) {
        
        let distanceLabelConstantHeight = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.centerY, multiplier: multiplier, constant: constant)
        
        view.superview?.addConstraint(distanceLabelConstantHeight)
    }
    
    func addCenterXYConstraints(_ view: UIView, toView: UIView, multiplier:CGFloat, constant: CGFloat) {
        
        addCenterXConstraint(view, toView: toView, multiplier: multiplier, constant: constant)
        addCenterYConstraint(view, toView: toView, multiplier: multiplier, constant: constant)
    }
    
    func addWidthHeightConstraints(_ view: UIView, toView: UIView?, multiplier:CGFloat, constant: CGFloat) {
   
        addHeightConstraint(view, toView: toView, multiplier: multiplier, constant: constant)
        addWidthConstraint(view, toView: toView, multiplier: multiplier, constant: constant)
    }
    
    func addWidthToHeightConstraints(_ view: UIView, toView: UIView?, multiplier:CGFloat, constant: CGFloat) {
        
        let widthToHeightConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: toView, attribute: NSLayoutAttribute.height, multiplier: multiplier, constant: constant)
        
        view.superview?.addConstraint(widthToHeightConstraint)
    }
    
    func addTopBottomConstraints(_ view: UIView, toView: UIView?, multiplier:CGFloat, constant: CGFloat) {
        
        addTopConstraint(view, toView: toView!, multiplier: multiplier, constant: constant)
        addBottomConstraint(view, toView: toView!, multiplier: multiplier, constant: constant)
    }
    
    func addLeftTopRightConstraints(_ view: UIView, toView: UIView?, multiplier:CGFloat, constant: CGFloat) {
        
        addLeftConstraint(view, toView: toView!, multiplier: multiplier, constant: constant)
        addTopConstraint(view, toView: toView!, multiplier: multiplier, constant: constant)
        addRightConstraint(view, toView: toView!, multiplier: multiplier, constant: constant)
        
    }

    func addLeftTopBottomConstraints(_ view: UIView, toView: UIView?, multiplier:CGFloat, constant: CGFloat) {
        
        addLeftConstraint(view, toView: toView!, multiplier: multiplier, constant: constant)
        addTopBottomConstraints(view, toView: toView!, multiplier: multiplier, constant: constant)
        
    }
    
    func addRightTopBottomConstraints(_ view: UIView, toView: UIView?, multiplier:CGFloat, constant: CGFloat) {
        
        addRightConstraint(view, toView: toView!, multiplier: multiplier, constant: constant)
        addTopBottomConstraints(view, toView: toView!, multiplier: multiplier, constant: constant)
        
    }
    
    
}
