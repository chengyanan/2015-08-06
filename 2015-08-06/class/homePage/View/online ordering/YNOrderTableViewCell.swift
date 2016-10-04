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
            
            if let _ = self.dataModel {
            
            
                self.setData()
            }
            
            
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
//                
//                if let tempDataModel = self.dataModel {
//               
//                    
//                    if let tempImage = tempDataModel.image {
//                        
//                        let url: NSURL? = NSURL(string: tempImage)
//                        
//                        if let tempUrl = url {
//                            
//                            let imageData: NSData? = NSData(contentsOfURL: tempUrl)
//                            
//                            if let tempData = imageData {
//                                
//                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                                    
//                                    self.businessImageView.image = UIImage(data: tempData)
//                                })
//                                
//                            }
//                            
//                        } else {
//                            
//                            print("\n 图片没有URL \n")
//                        }
//                        
//                    }
//
//                    
//                }
//                
//            })
//        
//            
//           
//            
            
        }
    }
    
    
    //MARK: - 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        self.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - private method
    
    func setData() {
        
        setImage()
      
        self.businessTitleLabel.text = dataModel?.title
        self.addressLabel.text = dataModel?.address
        self.distanceLabel.text = "3.6km"
        self.setLevel(Int(dataModel!.level!))
    }
    
    func setImage() {
   
        if let tempImage = dataModel!.image {
            
            let url: URL? = URL(string: tempImage)
            
            if let tempUrl = url {
                
                
                
                
                
                DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                    
                    
                    let imageData: Data? = try? Data(contentsOf: tempUrl)
                    
                    if let tempData = imageData {
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            self.businessImageView.image = UIImage(data: tempData)
                        })
                        
                    }
                        
                   
                }

                
                
//                DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: { () -> Void in
//                    
//                    let imageData: Data? = try? Data(contentsOf: tempUrl)
//                    
//                    if let tempData = imageData {
//                        
//                        DispatchQueue.main.async(execute: { () -> Void in
//                            
//                            self.businessImageView.image = UIImage(data: tempData)
//                        })
//                        
//                    }
//                    
//                })
                
                
            } else {
                
                print("\nYNOrderTableViewCell - 图片没有URL \n", terminator: "")
            }
            
        }

    }
    
    func setLevel(_ level: Int) {
        
        for i in 0 ..< ratingButtons.count {
            
            ratingButtons[i].isSelected = i < level
       
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
    func addLevelButtonLayout(_ view: UIView, toView: UIView) {

        Layout().addTopConstraint(view, toView: toView, multiplier: 1, constant: 0)
        Layout().addBottomConstraint(view, toView: toView, multiplier: 1, constant: 0)
        Layout().addWidthConstraint(view, toView: toView, multiplier: 1, constant: 0)
        Layout().addHeightConstraint(view, toView: toView, multiplier: 1, constant: 0)
        Layout().addLeftToRightConstraint(view, toView: toView, multiplier: 1, constant: 0)
       
    }
    
    //初始化一个星星button
    func buttonWithNormalImage(_ normalImage: String, selectedImage: String)-> UIButton {
        
        let button: UIButton = UIButton()
        button.isUserInteractionEnabled = false
        button.setImage(UIImage(named: normalImage), for: UIControlState())
        button.setImage(UIImage(named: selectedImage), for: UIControlState.selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.ratingButtons += [button]
        
        return button
    }
    
    //MARK: - private UI
    fileprivate let kImageViewWH: CGFloat = 18
    
    fileprivate lazy var businessImageView: UIImageView = {
        
        var tempImageView = UIImageView()
        tempImageView.contentMode = UIViewContentMode.scaleToFill
        tempImageView.translatesAutoresizingMaskIntoConstraints = false
        return tempImageView
        
        }()
    fileprivate lazy var businessTitleLabel: UILabel = {
        
        var tempLabel = UILabel()
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
        
        }()
    
    fileprivate var rating = 0
    fileprivate var ratingButtons = [UIButton]()
    
    fileprivate lazy var levelButton1: UIButton = {
        
        return self.buttonWithNormalImage("level_normal", selectedImage: "level_selected")
        }()
    fileprivate lazy var levelButton2: UIButton = {
        
        return self.buttonWithNormalImage("level_normal", selectedImage: "level_selected")
        }()
    fileprivate lazy var levelButton3: UIButton = {
        
        return self.buttonWithNormalImage("level_normal", selectedImage: "level_selected")
        }()
    fileprivate lazy var levelButton4: UIButton = {
        
        return self.buttonWithNormalImage("level_normal", selectedImage: "level_selected")
        }()
    fileprivate lazy var levelButton5: UIButton = {
        
        return self.buttonWithNormalImage("level_normal", selectedImage: "level_selected")
        }()
    
    fileprivate lazy var addressLabel: UILabel = {
        
        var tempLabel: UILabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        tempLabel.numberOfLines = 0
        tempLabel.textColor = UIColor.lightGray
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
        
        }()
    
    fileprivate lazy var distanceLabel: UILabel = {
        
        var tempLabel: UILabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 11)
        tempLabel.textAlignment = NSTextAlignment.left
        tempLabel.textColor = UIColor.lightGray
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
        
        }()
    

}
