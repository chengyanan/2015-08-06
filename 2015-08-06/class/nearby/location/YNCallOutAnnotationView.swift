//
//  YNCallOutAnnotationView.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/14.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import MapKit

class YNCallOutAnnotationView: MKAnnotationView {

    let kArror_height: CGFloat = 12//气泡尖角的高度
    let kCenterOffsetY: CGFloat = -73//中心点的Y向上偏移的高度
    let kSelfViewWidth: CGFloat = 170//自己的宽度
    let kSelfViewHeight: CGFloat = 76//自己的高度
    
    lazy var contentView: UIView = {
        
        return UIView(frame: CGRect(x: 0, y: 0, width: self.kSelfViewWidth, height: self.kSelfViewHeight-self.kArror_height))
        
        }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.centerOffset = CGPoint(x: 0, y: kCenterOffsetY);
        self.frame = CGRect(x: 0, y: 0, width: kSelfViewWidth, height: kSelfViewHeight);
        self.backgroundColor = UIColor.clear
        
    }

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//    }
//    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 出现的动画
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        animateIn()
    }
    
    
    
    func animateIn() {
   
        let scale: CGFloat = 0.001
        self.transform = CGAffineTransform(a: scale, b: 0, c: 0, d: scale, tx: 0, ty: 0)
        
        UIView.animate(withDuration: 0.15, animations: { () -> Void in
            
            let scaleIn: CGFloat = 1.1
            self.transform = CGAffineTransform(a: scaleIn, b: 0, c: 0, d: scaleIn, tx: 0, ty: 0)
            
        }, completion: { (Bool) -> Void in
            
          self.animateInStepTwo()
        }) 
    }
    
    func animateInStepTwo() {
        
        UIView.animate(withDuration: 0.075, animations: { () -> Void in
            
            let scale: CGFloat = 1.0
            self.transform = CGAffineTransform(a: scale, b: 0, c: 0, d: scale, tx: 0, ty: 0)
            
            }, completion: { (Bool) -> Void in
                
                
        }) 
        
    }
    
    //MARK: - 画一个背景气泡
    override func draw(_ rect: CGRect) {
        
        drawInContext(UIGraphicsGetCurrentContext()!)
        
        self.addSubview(contentView)

    }
    
    func drawInContext(_ context: CGContext) {
   
        context.setLineWidth(0.5)
        context.setFillColor(UIColor.white.cgColor)
        context.setStrokeColor(kStyleColor.cgColor)
        getDrawPath(context)
        context.drawPath(using: CGPathDrawingMode.fillStroke)
    }
    
    func getDrawPath(_ context: CGContext) {
        
        let rect = self.bounds
        let radius: CGFloat = 6.0
        
        let minx = rect.minX
        let midx = rect.midX
        let maxx = rect.maxX
        let miny = rect.minY
        let maxy = rect.maxY - kArror_height
        
        
        context.move(to: CGPoint(x: midx + kArror_height, y: maxy));
        //
        //        CGContextAddLineToPoint(context,midx, maxy + kArror_height);
        //        CGContextAddLineToPoint(context,midx - kArror_height, maxy);
        
        
        //CGContextAddArcToPoint(context, midx + kArror_height, maxy, midx, maxy + kArror_height, 3)
        
        context.addArc(tangent1End: CGPoint(x: midx + kArror_height, y: maxy), tangent2End: CGPoint(x: midx, y:  maxy + kArror_height), radius: 3)
        
        
        //CGContextAddArcToPoint(context, midx, maxy + kArror_height, midx - kArror_height, maxy, 3)
        
        context.addArc(tangent1End: CGPoint(x: midx, y: maxy + kArror_height), tangent2End: CGPoint(x: midx - kArror_height, y: maxy), radius: 3)
        
        // CGContextAddArcToPoint(context, midx - kArror_height, maxy, minx, maxy, 3)
        
        context.addArc(tangent1End: CGPoint(x: midx - kArror_height, y: maxy), tangent2End: CGPoint(x: minx, y: maxy), radius: 3)
        
        
        //CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
        
        context.addArc(tangent1End: CGPoint(x: minx, y: maxy), tangent2End: CGPoint(x: minx, y: miny), radius: radius)
        
        //CGContextAddArcToPoint(context, minx, miny, maxx, miny, radius);
        
        context.addArc(tangent1End: CGPoint(x: minx, y: miny), tangent2End: CGPoint(x: maxx, y: miny), radius: radius)
        
        //CGContextAddArcToPoint(context, maxx, miny, maxx, maxy, radius);
        
        context.addArc(tangent1End: CGPoint(x: maxx, y: miny), tangent2End: CGPoint(x: maxx, y: maxy), radius: radius)
        
        //CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
        
        context.addArc(tangent1End: CGPoint(x: maxx, y: maxy), tangent2End: CGPoint(x: midx, y: maxy), radius: radius)
        
    
        
        context.closePath();
        
    }
    
    //消失的时候有个动画

    
}
