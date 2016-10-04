//
//  YNCycleView.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/28.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

class YNCycleView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

    fileprivate let kTopHight = kScreenHeight * 0.264
    fileprivate let kIdentify: String = "CELL_CYCLE"
    var pageNumber: Int = 0
    
    var dataArray:Array<UIImage>? {
   
        didSet {
       
            self.pageControl.numberOfPages = dataArray!.count
            self.collectionView.reloadData()
        }
    }
    
    fileprivate lazy var collectionView:UICollectionView = {
        
        var flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kScreenWidth, height: self.kTopHight)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.minimumLineSpacing = 0
        
        var tempCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        tempCollectionView.isPagingEnabled = true
        tempCollectionView.bounces = false
        tempCollectionView.backgroundColor = UIColor.clear
        tempCollectionView.showsHorizontalScrollIndicator = false
        tempCollectionView.delegate = self
        tempCollectionView.dataSource = self
        return tempCollectionView
        }()
    
    fileprivate lazy var pageControl: UIPageControl = {
        
        var tempPageControl = UIPageControl()
        
        tempPageControl.currentPageIndicatorTintColor = kStyleColor
        tempPageControl.pageIndicatorTintColor = UIColor.purple
        tempPageControl.translatesAutoresizingMaskIntoConstraints = false
        
        return tempPageControl
        }()
    
    fileprivate lazy var timer: Timer = {
        var tempTimer = Timer(timeInterval: 4, target: self, selector: #selector(YNCycleView.scrollToforward), userInfo: nil, repeats: true)
        
        return tempTimer
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.addSubview(collectionView)
        self.addSubview(pageControl)
        self.collectionView.register(YNCycleCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: kIdentify)
        
        let constraintCenterX: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.pageControl, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
        let constraintBottom: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.pageControl, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
        let constraintHeight: NSLayoutConstraint = NSLayoutConstraint(item: self.pageControl, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 0, constant: 16)
        
        self.addConstraint(constraintCenterX)
        self.addConstraint(constraintBottom)
        self.addConstraint(constraintHeight)
        
        RunLoop.main.add(self.timer, forMode: RunLoopMode.commonModes)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UICollectionViewDataSource 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataArray!.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: YNCycleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: kIdentify, for: indexPath) as! YNCycleCollectionViewCell
        cell.image = self.dataArray![(indexPath as NSIndexPath).item]
        return cell
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageFloat: CGFloat = (scrollView.contentOffset.x + kScreenWidth/2) / kScreenWidth
        let pageInt: Int = Int(pageFloat)
        self.pageControl.currentPage = pageInt
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        pauseTimer()
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        startTimer()
    }
    
    //MARK: - private method
    fileprivate func pauseTimer() {
   
        self.timer.fireDate = Date.distantFuture 
    }
    fileprivate func startTimer() {
   
        self.timer.fireDate = Date(timeIntervalSinceNow: 1)
    }
    
    //MARK: - event responsor 
    func scrollToforward() {
        
        self.pageNumber += 1
        let row = self.pageNumber % self.dataArray!.count
        let indexPath: IndexPath = IndexPath(row: row, section: 0)
        
        self.collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: true)
    }
}
