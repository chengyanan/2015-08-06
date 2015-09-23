//
//  YNCycleCollectionViewCell.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/27.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

class YNCycleCollectionViewCell: UICollectionViewCell {
    
    var image: UIImage? {
   
        didSet {
       
            self.imageView.image = image
        }
    }
    
    private lazy var imageView: UIImageView = {
        
        var tempImageView = UIImageView(frame: self.bounds)
        
        return tempImageView
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
