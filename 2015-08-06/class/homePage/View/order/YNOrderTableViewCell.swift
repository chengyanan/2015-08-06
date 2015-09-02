//
//  YNOrderTableViewCell.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/31.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

class YNOrderTableViewCell: UITableViewCell {

    //MARK: - public proterty
    var dataModel: Restaurant? {
   
        didSet {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                
                if let tempDataModel = self.dataModel {
               
                    
                    if let tempImage = tempDataModel.image {
                        
                        let url: NSURL? = NSURL(string: tempImage)
                        
                        if let tempUrl = url {
                            
                            let imageData: NSData? = NSData(contentsOfURL: tempUrl)
                            
                            if let tempData = imageData {
                                
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    
                                    self.businessImageView.image = UIImage(data: tempData)
                                })
                                
                            }
                            
                        } else {
                            
                            print("\n 图片没有URL \n")
                        }
                        
                    }

                    
                }
                
            })
            
//            self.businessImageView.image = UIImage(named: "image")
            self.businessTitleLabel.text = dataModel?.title
            self.addressLabel.text = dataModel?.address
            self.distanceLabel.text = "3.6km"
            self.setLevel(Int(dataModel!.level!))
            
        }
    }
    
    
    //MARK: - 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.autoresizingMask = UIViewAutoresizing.FlexibleHeight|UIViewAutoresizing.FlexibleWidth
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        self.contentView.addSubview(businessImageView)
        self.contentView.addSubview(businessTitleLabel)
        self.contentView.addSubview(levelButton1)
        self.contentView.addSubview(levelButton2)
        self.contentView.addSubview(levelButton3)
        self.contentView.addSubview(levelButton4)
        self.contentView.addSubview(levelButton5)
        self.contentView.addSubview(addressLabel)
        self.contentView.addSubview(distanceLabel)
        
        setLayout()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - private method
    
    func setLevel(level: Int) {
        
        for var i = 0; i < ratingButtons.count; ++i {
            
            ratingButtons[i].selected = i < level
       
        }
    }
    
    func setLayout() {
        
        //图片
        Layout().addLeftConstraint(businessImageView, toView: self.contentView, multiplier: 1, constant: 3)
        Layout().addTopConstraint(businessImageView, toView: self.contentView, multiplier: 1, constant: 10)
        Layout().addBottomConstraint(businessImageView, toView: self.contentView, multiplier: 1, constant: -10)
        Layout().addWidthConstraint(businessImageView, toView: nil, multiplier: 0, constant: 69)
        
        //标题
        Layout().addTopConstraint(businessTitleLabel, toView: businessImageView, multiplier: 1, constant: -2)
        Layout().addHeightConstraint(businessTitleLabel, toView: nil, multiplier: 0, constant: 20)
        Layout().addLeftToRightConstraint(businessTitleLabel, toView: businessImageView, multiplier: 1, constant: 6)
        Layout().addRightConstraint(businessTitleLabel, toView: self.contentView, multiplier: 1, constant: 0)
        
        //第一颗星
        Layout().addTopToBottomConstraint(levelButton1, toView: businessTitleLabel, multiplier: 1, constant: 0)
        Layout().addLeftConstraint(levelButton1, toView: businessTitleLabel, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(levelButton1, toView: nil, multiplier: 0, constant: kImageViewWH + 4.8)
        Layout().addHeightConstraint(levelButton1, toView: nil, multiplier: 0, constant: kImageViewWH)
        
        //第二到第五颗星
        addLevelButtonLayout(levelButton2, toView: levelButton1)
        addLevelButtonLayout(levelButton3, toView: levelButton2)
        addLevelButtonLayout(levelButton4, toView: levelButton3)
        addLevelButtonLayout(levelButton5, toView: levelButton4)
        
        //距离
        Layout().addRightConstraint(distanceLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(distanceLabel, toView: self.contentView, multiplier: 1, constant: 0)
        Layout().addTopToBottomConstraint(distanceLabel, toView: levelButton1, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(distanceLabel, toView: nil, multiplier: 0, constant: 50)
        
        //地址
        Layout().addTopConstraint(addressLabel, toView: distanceLabel, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(addressLabel, toView: distanceLabel, multiplier: 1, constant: 0)
        Layout().addLeftConstraint(addressLabel, toView: levelButton1, multiplier: 1, constant: 0)
        Layout().addRightConstraint(addressLabel, toView: distanceLabel, multiplier: 1, constant: -55)
        
    }
    
    //设置后面4个星星button的位置
    func addLevelButtonLayout(view: UIView, toView: UIView) {

        Layout().addTopConstraint(view, toView: toView, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(view, toView: toView, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(view, toView: toView, multiplier: 1, constant: 0)
        Layout().addHeightConstraint(view, toView: toView, multiplier: 1, constant: 0)
        Layout().addLeftToRightConstraint(view, toView: toView, multiplier: 1, constant: 0)
       
    }
    
    //初始化一个星星button
    func buttonWithNormalImage(normalImage: String, selectedImage: String)-> UIButton {
        
        var button: UIButton = UIButton()
        button.userInteractionEnabled = false
        button.setImage(UIImage(named: normalImage), forState: UIControlState.Normal)
        button.setImage(UIImage(named: selectedImage), forState: UIControlState.Selected)
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.ratingButtons += [button]
        
        return button
    }
    
    //MARK: - private UI
    private let kImageViewWH: CGFloat = 18
    
    private lazy var businessImageView: UIImageView = {
        
        var tempImageView = UIImageView()
        tempImageView.contentMode = UIViewContentMode.ScaleToFill
        tempImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return tempImageView
        
        }()
    private lazy var businessTitleLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        return tempLabel
        
        }()
    
    private var rating = 0
    private var ratingButtons = [UIButton]()
    
    private lazy var levelButton1: UIButton = {
        
        return self.buttonWithNormalImage("level_normal", selectedImage: "level_selected")
        }()
    private lazy var levelButton2: UIButton = {
        
        return self.buttonWithNormalImage("level_normal", selectedImage: "level_selected")
        }()
    private lazy var levelButton3: UIButton = {
        
        return self.buttonWithNormalImage("level_normal", selectedImage: "level_selected")
        }()
    private lazy var levelButton4: UIButton = {
        
        return self.buttonWithNormalImage("level_normal", selectedImage: "level_selected")
        }()
    private lazy var levelButton5: UIButton = {
        
        return self.buttonWithNormalImage("level_normal", selectedImage: "level_selected")
        }()
    
    private lazy var addressLabel: UILabel = {
        
        var tempLabel: UILabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(13)
        tempLabel.numberOfLines = 0
        tempLabel.textColor = UIColor.lightGrayColor()
        tempLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        return tempLabel
        
        }()
    
    private lazy var distanceLabel: UILabel = {
        
        var tempLabel: UILabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(11)
        tempLabel.textAlignment = NSTextAlignment.Left
        tempLabel.textColor = UIColor.lightGrayColor()
        tempLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        return tempLabel
        
        }()
    

}
