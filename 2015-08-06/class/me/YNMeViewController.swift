//
//  YNMeViewController.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/6.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import UIKit

class YNMeViewController: UIViewController, UITableViewDataSource, YNSignInViewControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = signInBarButtonItem
        self.view.addSubview(self.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    func signInItemHasClicked() {
   
        if self.signInBarButtonItem.title == "登录" {
       
            let signInVc = YNSignInViewController()
            signInVc.delegate = self
            let signInNav = YNNavigationController(rootViewController: signInVc)
            self.navigationController?.present(signInNav, animated: true, completion: { () -> Void in
                
            })
            
        } else if self.signInBarButtonItem.title == "退出" {
            
            Tools().removeValueForKey(kUserKey)
            self.tableView.reloadData()
            
            signInBarButtonItem.title = "登录"
        }
        
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identify: String = "Cell_ID"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identify)
        if cell == nil {
       
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identify)
        }
        
        if kUser_MobileNumber() != nil {
       
            let number: String = kUser_MobileNumber() as! String
            
            cell?.textLabel?.text = "当前登录帐号为: \(number)"
        } else {
       
            cell?.textLabel?.text = "未登录"
        }
        
        return cell!
    }
    
    //MARK: - YNSignInViewControllerDelegate
    
    func logInSuccess() {
        
        signInBarButtonItem.title = "退出"
    }
    
    lazy var signInBarButtonItem: UIBarButtonItem = {
        
        var item: UIBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.plain, target: self, action: #selector(YNMeViewController.signInItemHasClicked))
        
        if let user: AnyObject = kUser_MobileNumber() {
        
            item.title = "退出"
        } else {
       
            item.title = "登录"
        }
        
            return item
    }()

    lazy var tableView:UITableView = {
   
        var tempTableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.grouped)
        
        tempTableView.dataSource = self
        
        return tempTableView
    }()
}
