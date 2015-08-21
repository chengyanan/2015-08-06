//
//  YNSignInViewController.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/7.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

protocol YNSignInViewControllerDelegate {
    
    func logInSuccess()
}

class YNSignInViewController: UIViewController {

    let kMargin: CGFloat = 12
    let kTextFileHeight: CGFloat = 44
    let kVerticalSpace: CGFloat = 3
    let kTopMargin: CGFloat = 18 + 64
    let kMarginSignUp: CGFloat = 11
    
    var delegate: YNSignInViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "登录"
        self.view.backgroundColor = kRGBA(243, 240, 236, 1.0)
        
        self.navigationItem.rightBarButtonItem = signInBarButtonItem
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        
        self.view.addSubview(self.userNameTextFiled)
        self.view.addSubview(self.passwordTextFiled)
        self.view.addSubview(self.signInButton)
        
        setLayout()
    }
    
//MARK: event response
    func signUpItemHasClicked() {
        
        var signUpVc = YNSignUpViewController()

        self.navigationController?.pushViewController(signUpVc, animated: true)
    }
    
    func backBarButtonItemHasClicked() {
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func signInButtonHasClicked() {
   
        if let userName = self.userNameTextFiled.text {
            
            if Tools().isPhoneNumber(userName) {
                
                if let password = self.passwordTextFiled.text {
               
                    //向服务器发送登录请求
                    logIning()
                    
                } else {
               
                    YNProgressHUD().showText("请输入密码", toView: self.view)
                }
                
            } else {
           
                YNProgressHUD().showText("输入的号码格式错误", toView: self.view)
            }
            
        } else {
       
            YNProgressHUD().showText("请输入用户名", toView: self.view)
        }
    }
    
    func logIning() {
   
        var params = ["key":"edge5de7se4b5xd",
            "action": "login",
            "username": self.userNameTextFiled.text,
            "password": self.passwordTextFiled.text]
        
        var progress = YNProgressHUD().showWaitingToView(self.view)
        self.signInButton.userInteractionEnabled = false
        
        Network.post(kURL, params: params, success: { (data, response, error) -> Void in
            
            progress.hideUsingAnimation()
            self.signInButton.userInteractionEnabled = true
            
//             print(data)
            
            
            let json: NSDictionary =  NSJSONSerialization.JSONObjectWithData(data , options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            
//            print("data - \(json)")
            
            if let status = json["status"] as? Int {
                
                if status == 1 {
                    
                    //把用户名保存到本地
                    Tools().saveValue(self.userNameTextFiled.text, forKey: "User_MobileNumber")
                    
                    if self.delegate != nil {
                   
                        self.delegate?.logInSuccess()
                    }
                    
                    self.dismissViewControllerAnimated(true, completion: { () -> Void in
                        
                        YNProgressHUD().showText("登录成功", toView: UIApplication.sharedApplication().keyWindow!)
                    })
                    
                } else if status == 0 {
                    
                    if let msg = json["msg"] as? String {
                        
                        YNProgressHUD().showText(msg, toView: self.view)
                    }
                }
                
            }
            
            }) { (error) -> Void in
                
                progress.hideUsingAnimation()
                self.signInButton.userInteractionEnabled = true
                
                YNProgressHUD().showText("登录失败", toView: self.view)
        }

    }
    
    //MARK: getter
    var signInBarButtonItem: UIBarButtonItem {
        
        get {
            return UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "signUpItemHasClicked")
        }
    }

    var backBarButtonItem: UIBarButtonItem {
        
        get {
            
            return UIBarButtonItem(image: UIImage(named: "system_back"), style: UIBarButtonItemStyle.Plain, target: self, action: "backBarButtonItemHasClicked")
        }
    }

    lazy var userNameTextFiled: UITextField! = {
        
        var tempTextFiled = UITextField()
        
        tempTextFiled.setTextFiledWithLeftImageName("register_userName", customRightView: nil, placeHolder: "请输入手机号", keyBoardTypePara: UIKeyboardType.NumberPad)
        
        return tempTextFiled
        }()
    
    lazy var passwordTextFiled: UITextField! = {
        
        var tempTextFiled = UITextField()
        tempTextFiled.secureTextEntry = true
        tempTextFiled.setTextFiledWithLeftImageName("register_password", customRightView: nil, placeHolder: "请输入密码", keyBoardTypePara: UIKeyboardType.Default)
        
        return tempTextFiled
        }()
    
    lazy var signInButton: UIButton! = {
        var button = UIButton()
        
        button.layer.cornerRadius = 3
        button.backgroundColor = kStyleColor
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.setTitle("登录", forState: UIControlState.Normal)
        button.addTarget(self, action: "signInButtonHasClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
        }()
    
    func setLayout() {
        
        let textFiledWidth = kScreenWidth - kMargin * 2
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-kMargin-[tempTextFiled(textFiledWidth)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: ["kMargin": kMargin, "textFiledWidth": textFiledWidth], views: ["tempTextFiled": userNameTextFiled]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-kTopMargin-[tempTextFiled(kTextFileHeight)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: ["kTopMargin": kTopMargin, "kTextFileHeight": kTextFileHeight], views: ["tempTextFiled": userNameTextFiled]))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-kMargin-[passwordTextFiled(textFiledWidth)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: ["kMargin": kMargin, "textFiledWidth": textFiledWidth], views: ["passwordTextFiled": passwordTextFiled]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[userNameTextFiled]-kVerticalSpace-[passwordTextFiled(kTextFileHeight)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: ["kVerticalSpace": kVerticalSpace, "kTextFileHeight": kTextFileHeight], views: ["passwordTextFiled": passwordTextFiled, "userNameTextFiled": userNameTextFiled]))
        
        let textFiledWidthSignUp = kScreenWidth - kMarginSignUp * 2
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-kMarginSignUp-[signInButton(textFiledWidthSignUp)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: ["kMarginSignUp": kMarginSignUp, "textFiledWidthSignUp": textFiledWidthSignUp], views: ["signInButton": signInButton]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[passwordTextFiled]-kVerticalSpace-[signInButton(kTextFileHeight)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: ["kVerticalSpace": kVerticalSpace*4, "kTextFileHeight": kTextFileHeight], views: ["passwordTextFiled": passwordTextFiled, "signInButton": signInButton]))
        
    }
}
