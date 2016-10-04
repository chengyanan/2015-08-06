//
//  YNSignUpViewController.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/7.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

//#define iphone6   ScreenHeight == 667

class YNSignUpViewController: UIViewController {
    
    let kMargin: CGFloat = 12
    let kTextFileHeight: CGFloat = 44
    let kVerticalSpace: CGFloat = 3
    let kTopMargin: CGFloat = 18
    let kMarginSignUp: CGFloat = 11
    
    let totalSecong = 120
    let codeDigit: Int = 4
    
    var second: Int = 60
    var timer: Timer?
    var code: String?
    var originalContentSize: CGSize!
    
    //MARK:- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "注册"
        self.view.backgroundColor = kRGBA(243, g: 240, b: 236, a: 1.0)
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(userNameTextFiled)
        scrollView.addSubview(securityCodeTextField)
        scrollView.addSubview(passwordTextFiled)
        scrollView.addSubview(passwordAgainTextFiled)
        scrollView.addSubview(signUpButton)
        
        setupLayout()
        
        addKeyBoardNotification()
        
        addTapGestureRecongizer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
        self.timer?.invalidate()
    }
// MARK: - event response
    
    //点击获取验证码
     internal func getCodeButtonHasClicked() {
        
        if Tools().isPhoneNumber(self.userNameTextFiled.text!) {
            
            self.getcodeButton.isUserInteractionEnabled = false
            self.getcodeButton.backgroundColor = UIColor.gray
            
            //等待动画
            showWaitingSecond()
            
            //生成验证码然后传给服务器,由服务器把验证码传到手机端
            generateCodeAndSendToServer()
        
        } else {
        
            YNProgressHUD().showText("您输入的号码不正确", toView: self.view)
            
        }
        
    }
    
     func signUpButtonHasClicked() {
        
        let allFill : Bool = (self.userNameTextFiled.text!.characters.count != 0) && (self.securityCodeTextField.text!.characters.count != 0) && (self.passwordTextFiled.text!.characters.count != 0) && (self.passwordAgainTextFiled.text!.characters.count != 0)
        
        if allFill {
            
            
            if Tools().isPhoneNumber(self.userNameTextFiled.text!) {
                
                if self.passwordTextFiled.text == self.passwordAgainTextFiled.text {
                    
//                    if self.code == self.securityCodeTextField.text {
//                   
//                        //填写正确, 向服务器发送用户名和密码
//                        senderDataToServer()
//                        
//                    }else {
//                   
//                        YNProgressHUD().showText("验证码不正确", toView: self.view)
//                    }
                    
                    senderDataToServer()
                    
                } else {
                    
                    YNProgressHUD().showText("密码填写不一致", toView: self.view)
                }
                
            } else {
                
                YNProgressHUD().showText("您输入的号码不正确", toView: self.view)
            }
       
            
        } else {
            
            YNProgressHUD().showText("信息填写不完整", toView: self.view)
        }
        
    }
    
    func keyboardWillShow(_ notification: Notification) {
   
        if kIS_iPhone4() || kIS_iPhone5() {
       
            var userInfo: [AnyHashable: Any]? = (notification as NSNotification).userInfo
            
            let aValue: AnyObject? = userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject?
            
            if let rect = aValue?.cgRectValue {
                
                let height = rect.size.height
                self.originalContentSize = self.scrollView.contentSize
                
                if kIS_iPhone4() {
                    self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height + height*0.5 - 64);
                }
                
                if kIS_iPhone5() {
                    
                    self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height );
                }
            }
            
        }
        
    }
   
     func keyboardWillHide(_ notification: Notification) {
   
        if kIS_iPhone4() || kIS_iPhone5() {
       
            self.scrollView.contentSize = self.originalContentSize
            
        }
    }
    
     func tapBackView() {
   
        self.view.endEditing(true)
    }
    
// MARK: - custom method
    
    func showWaitingSecond() {
        
        self.timer = Timer(timeInterval: 1, target: self, selector: #selector(YNSignUpViewController.addOneSecond), userInfo: nil, repeats: true)
        self.timer?.fire()
        
        RunLoop.main.add(self.timer!, forMode: RunLoopMode.commonModes)
    }
    
    func addOneSecond() {

        self.second -= 1
        
//        print(self.second)
        if self.second > 0 {
            
            self.getcodeButton.setTitle("\(self.second)s", for: UIControlState())
            
        } else {
       
            self.timer?.invalidate()
            self.getcodeButton.isUserInteractionEnabled = true
            self.getcodeButton.setTitle("获取", for: UIControlState())
            self.getcodeButton.backgroundColor = kStyleColor
            self.second = 60
        }
        
    }
    
     func generateCodeAndSendToServer() {
        
        var code: String = ""
        
        for _ in 1...self.codeDigit {
            
            let number = self.randomInRange(1..<5)
            code += String(number)
        }
        
        self.code = code
        
        // 把验证码发给服务器，服务器发到手机端
        senderCodeToServer(code)
        
    }
    
     func senderCodeToServer(_ code: String) {
   
        let params = ["key":"edge5de7se4b5xd",
            "action": "regverify",
            "mobile": self.userNameTextFiled.text,
            "code": code] as [String : Any]
        
        
        Network.post(kURL, params: params as! [String : String?], success: { (data, response, error) -> Void in
            
            let json: NSDictionary =  ((try! JSONSerialization.jsonObject(with: data! , options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSDictionary)!
            
            print("data - \(json)", terminator: "")
            
            if let status = json["status"] as? Int {
                
                if status == 1 {
                    
                    
                    
                } else if status == 0 {
                    
                    if let msg = json["msg"] as? String {
                        
                        YNProgressHUD().showText(msg, toView: self.view)
                    }
                    self.getcodeButton.isUserInteractionEnabled = true
                }
                
            }
            
        }) { (error) -> Void in
        
            YNProgressHUD().showText("获取验证码失败", toView: self.view)
            self.getcodeButton.isUserInteractionEnabled = true
        }
        
       
    }
    
     //点击了注册按钮
     func senderDataToServer() {
        
        self.signUpButton.isUserInteractionEnabled = false
        
        let params = ["key":"edge5de7se4b5xd",
            "action": "reg",
            "mobile": self.userNameTextFiled.text! as String,
            "password": self.passwordTextFiled.text! as String]
        
        
        let progress: ProgressHUD = YNProgressHUD().showWaitingToView(self.view)
         
        Network.post(kURL, params: params, success: { (data, response, error) -> Void in
            
            progress.hideUsingAnimation()
            
//            print(data)
            
            let json: NSDictionary = (try! JSONSerialization.jsonObject(with: data! , options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary

//            print("data - \(json)")
            
            if let status = json["status"] as? Int {
        
                if status == 1 {
                    
                    //把用户名保存到本地
                    Tools().saveValue(self.userNameTextFiled.text as AnyObject?, forKey: kUserKey)
                    
                    self.navigationController?.childViewControllers[0].dismiss(animated: true, completion: { () -> Void in
                        
                        YNProgressHUD().showText("注册成功", toView: UIApplication.shared.keyWindow!)
                        
                        })
                    
                } else if status == 0 {
                    
                    if let msg = json["msg"] as? String {
                        
                        YNProgressHUD().showText(msg, toView: self.view)
                    }
                    self.signUpButton.isUserInteractionEnabled = true
                }
                
            }
            
            
        }) { (error) -> Void in
            
            progress.hideUsingAnimation()
            
            YNProgressHUD().showText("请求失败", toView: self.view)
            self.signUpButton.isUserInteractionEnabled = true
        }
        
    }

    
    func randomInRange(_ range: Range<Int>) ->Int {
        let count = UInt32(range.upperBound - range.lowerBound)
        return Int(arc4random_uniform(count)) + range.lowerBound
    }
    
     func addKeyBoardNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(YNSignUpViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(YNSignUpViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
     func addTapGestureRecongizer() {
        
        let tgr: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(YNSignUpViewController.tapBackView))
        self.view.addGestureRecognizer(tgr)
        
    }
    
 // MARK: - getter
    lazy var scrollView: UIScrollView! = {
   
        var tempscrollView = UIScrollView()
        tempscrollView.translatesAutoresizingMaskIntoConstraints = false
        return tempscrollView
    }()
  
     lazy var userNameTextFiled: UITextField! = {
        
        var tempTextFiled = UITextField()
        
        tempTextFiled.setTextFiledWithLeftImageName("register_userName", customRightView: nil, placeHolder: "请输入手机号", keyBoardTypePara: UIKeyboardType.numberPad)

        return tempTextFiled
        }()
    
     lazy var securityCodeTextField: UITextField! = {
        
        var tempTextFiled = UITextField()
        tempTextFiled.setTextFiledWithLeftImageName("register_verficationCode", customRightView: self.getcodeButton, placeHolder: "验证码", keyBoardTypePara: UIKeyboardType.numberPad)

        return tempTextFiled
        }()
    
     lazy var getcodeButton: UIButton! = {
        var button = UIButton()
        
        button.frame = CGRect(x: 0, y: 0, width: 72, height: 40)
        button.layer.cornerRadius = 3
        button.backgroundColor = kStyleColor
        
        button.setTitle("获取", for: UIControlState())
        button.addTarget(self, action: #selector(YNSignUpViewController.getCodeButtonHasClicked), for: UIControlEvents.touchUpInside)
        
        return button
    }()
    
     lazy var passwordTextFiled: UITextField! = {
        
        var tempTextFiled = UITextField()
        tempTextFiled.isSecureTextEntry = true
        tempTextFiled.setTextFiledWithLeftImageName("register_password", customRightView: nil, placeHolder: "请输入密码", keyBoardTypePara: UIKeyboardType.default)
        
        return tempTextFiled
        }()

     lazy var passwordAgainTextFiled: UITextField! = {
        
        var tempTextFiled = UITextField()
        tempTextFiled.isSecureTextEntry = true
        tempTextFiled.setTextFiledWithLeftImageName("register_password", customRightView: nil, placeHolder: "请再次输入密码", keyBoardTypePara: UIKeyboardType.default)
        
        return tempTextFiled
        }()

     lazy var signUpButton: UIButton! = {
        var button = UIButton()
        
        button.layer.cornerRadius = 3
        button.backgroundColor = kStyleColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("注册", for: UIControlState())
        button.addTarget(self, action: #selector(YNSignUpViewController.signUpButtonHasClicked), for: UIControlEvents.touchUpInside)

        return button
        }()

     func setupLayout() {
        
        let scrollViewConstrantVFLH = "H:|[scrollView]|"
        let scrollViewConstrantVFLV = "V:|[scrollView]|"
        
        let scrollViewConstrantH = NSLayoutConstraint.constraints(withVisualFormat: scrollViewConstrantVFLH, options: NSLayoutFormatOptions(), metrics: nil, views: ["scrollView": scrollView])
        let scrollViewConstrantV = NSLayoutConstraint.constraints(withVisualFormat: scrollViewConstrantVFLV, options: NSLayoutFormatOptions(), metrics: nil, views: ["scrollView": scrollView])
        self.view.addConstraints(scrollViewConstrantH)
        self.view.addConstraints(scrollViewConstrantV)
        
        let textFiledWidth = kScreenWidth - kMargin * 2
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-kMargin-[tempTextFiled(textFiledWidth)]|", options: NSLayoutFormatOptions(), metrics: ["kMargin": kMargin, "textFiledWidth": textFiledWidth], views: ["tempTextFiled": userNameTextFiled]))
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-kTopMargin-[tempTextFiled(kTextFileHeight)]|", options: NSLayoutFormatOptions(), metrics: ["kTopMargin": kTopMargin, "kTextFileHeight": kTextFileHeight], views: ["tempTextFiled": userNameTextFiled]))
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-kMargin-[securityCodeTextField(textFiledWidth)]|", options: NSLayoutFormatOptions(), metrics: ["kMargin": kMargin, "textFiledWidth": textFiledWidth], views: ["securityCodeTextField": securityCodeTextField]))
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[userNameTextFiled]-kVerticalSpace-[securityCodeTextField(kTextFileHeight)]", options:  NSLayoutFormatOptions(), metrics: ["kVerticalSpace": kVerticalSpace, "kTextFileHeight": kTextFileHeight], views: ["userNameTextFiled": userNameTextFiled, "securityCodeTextField": securityCodeTextField]))
        
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-kMargin-[passwordTextFiled(textFiledWidth)]|", options: NSLayoutFormatOptions(), metrics: ["kMargin": kMargin, "textFiledWidth": textFiledWidth], views: ["passwordTextFiled": passwordTextFiled]))
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[securityCodeTextField]-kVerticalSpace-[passwordTextFiled(kTextFileHeight)]", options: NSLayoutFormatOptions(), metrics: ["kVerticalSpace": kVerticalSpace, "kTextFileHeight": kTextFileHeight], views: ["passwordTextFiled": passwordTextFiled, "securityCodeTextField": securityCodeTextField]))
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-kMargin-[passwordAgainTextFiled(textFiledWidth)]|", options: NSLayoutFormatOptions(), metrics: ["kMargin": kMargin, "textFiledWidth": textFiledWidth], views: ["passwordAgainTextFiled": passwordAgainTextFiled]))
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[passwordTextFiled]-kVerticalSpace-[passwordAgainTextFiled(kTextFileHeight)]", options: NSLayoutFormatOptions(), metrics: ["kVerticalSpace": kVerticalSpace, "kTextFileHeight": kTextFileHeight], views: ["passwordTextFiled": passwordTextFiled, "passwordAgainTextFiled": passwordAgainTextFiled]))
        
        
        let textFiledWidthSignUp = kScreenWidth - kMarginSignUp * 2
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-kMarginSignUp-[signUpButton(textFiledWidthSignUp)]", options: NSLayoutFormatOptions(), metrics: ["kMarginSignUp": kMarginSignUp, "textFiledWidthSignUp": textFiledWidthSignUp], views: ["signUpButton": signUpButton]))
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[passwordAgainTextFiled]-kVerticalSpace-[signUpButton(kTextFileHeight)]", options: NSLayoutFormatOptions(), metrics: ["kVerticalSpace": kVerticalSpace*4, "kTextFileHeight": kTextFileHeight], views: ["passwordAgainTextFiled": passwordAgainTextFiled, "signUpButton": signUpButton]))
    }

}
