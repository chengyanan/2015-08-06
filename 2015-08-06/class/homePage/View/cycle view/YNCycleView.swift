//
//  YNCycleView.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/28.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

class YNCycleView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

    private let kTopHight = kScreenHeight * 0.264
    private let kIdentify: String = "CELL_CYCLE"
    var pageNumber: Int = 0
    
    var dataArray:Array<UIImage>? {
   
        didSet {
       
            self.pageControl.numberOfPages = dataArray!.count
            self.collectionView.reloadData()
        }
    }
    
    private lazy var collectionView:UICollectionView = {
        
        var flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(kScreenWidth, self.kTopHight)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        flowLayout.minimumLineSpacing = 0
        
        var tempCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        tempCollectionView.pagingEnabled = true
        tempCollectionView.bounces = false
        tempCollectionView.backgroundColor = UIColor.clearColor()
        tempCollectionView.showsHorizontalScrollIndicator = false
        tempCollectionView.delegate = self
        tempCollectionView.dataSource = self
        return tempCollectionView
        }()
    
    private lazy var pageControl: UIPageControl = {
        
        var tempPageControl = UIPageControl()
        
        tempPageControl.currentPageIndicatorTintColor = kStyleColor
        tempPageControl.pageIndicatorTintColor = UIColor.purpleColor()
        tempPageControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        return tempPageControl
        }()
    
    private lazy var timer: NSTimer = {
        var tempTimer = NSTimer(timeInterval: 4, target: self, selector: "scrollToforward", userInfo: nil, repeats: true)
        
        return tempTimer
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.addSubview(collectionView)
        self.addSubview(pageControl)
        self.collectionView.registerClass(YNCycleCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: kIdentify)
        
        let constraintCenterX: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.pageControl, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        let constraintBottom: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.pageControl, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        let constraintHeight: NSLayoutConstraint = NSLayoutConstraint(item: self.pageControl, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 0, constant: 16)
        
        self.addConstraint(constraintCenterX)
        self.addConstraint(constraintBottom)
        self.addConstraint(constraintHeight)
        
        NSRunLoop.mainRunLoop().addTimer(self.timer, forMode: NSRunLoopCommonModes)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UICollectionViewDataSource 
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataArray!.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell: YNCycleCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(kIdentify, forIndexPath: indexPath) as! YNCycleCollectionViewCell
        cell.image = self.dataArray![indexPath.item]
        return cell
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var pageFloat: CGFloat = (scrollView.contentOffset.x + kScreenWidth/2) / kScreenWidth
        var pageInt: Int = Int(pageFloat)
        self.pageControl.currentPage = pageInt
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        pauseTimer()
    }
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        startTimer()
    }
    
    //MARK: - private method
    private func pauseTimer() {
   
        self.timer.fireDate = NSDate.distantFuture() as! NSDate
    }
    private func startTimer() {
   
        self.timer.fireDate = NSDate(timeIntervalSinceNow: 1)
    }
    
    //MARK: - event responsor 
    func scrollToforward() {
        
        self.pageNumber++
        let row = self.pageNumber % self.dataArray!.count
        let indexPath: NSIndexPath = NSIndexPath(forRow: row, inSection: 0)
        
        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
    }
}
