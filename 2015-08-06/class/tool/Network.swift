//
//  Network.swift
//  2015-08-06
//
//  Created by 农盟 on 15/8/12.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

import Foundation
import UIKit

class Network {
    
    static func get(_ url: String, params: [String: String?], success: @escaping (_ data: Data, _ response: URLResponse, _ error: NSError?)->Void, failure: @escaping (_ error: NSError)->Void) {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            let manager = NetworkManager(method: "GET", url: url, params: params, success: success, failure: failure)
            manager.fire()
        }

        
//        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: { () -> Void in
//            
//            let manager = NetworkManager(method: "GET", url: url, params: params, success: success, failure: failure)
//            manager.fire()
//        
//        })
        
    }
    
    static func post(_ url: String, params: [String: String?], success: @escaping (_ data: Data?, _ response: URLResponse?, _ error: NSError?)->Void, failure: @escaping (_ error: NSError?)->Void) {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            let manager = NetworkManager(method: "POST", url: url, params: params, success: success, failure: failure)
            manager.fire()
            
        }

        
//        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: { () -> Void in
//            
//            let manager = NetworkManager(method: "POST", url: url, params: params, success: success, failure: failure)
//            manager.fire()
//        })

    }
    
    static func getImageWithURL(_ url: String, success:@escaping (_ data: Data)->Void) {
   
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            let session = URLSession.shared
            
            session.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) -> Void in
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    success(data!)
                })
                
                
            })
        }
        
        
//        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: { () -> Void in
//            
//            let session = URLSession.shared
//            
//            session.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) -> Void in
//                
//                DispatchQueue.main.async(execute: { () -> Void in
//                    
//                    success(data!)
//                })
//                
//                
//            })
//            
//        })
        
        
        
    }
}

class NetworkManager {
    let method: String!
    let url: String!
    let params: [String: String?]
    let success: (_ data: Data, _ response: URLResponse, _ error: NSError?)->Void
    let failure: (_ error: NSError)->Void
    let session = URLSession.shared
    var request: NSMutableURLRequest!
    var task: URLSessionTask!
    
    init(method: String, url: String, params: [String: String?], success: @escaping (_ data: Data, _ response: URLResponse, _ error: NSError?)->Void, failure: @escaping (_ error: NSError)->Void) {
   
        self.method = method
        self.url = url
        self.params = params
        self.success = success
        self.failure = failure
        self.request = NSMutableURLRequest(url: URL(string: url)!)
        self.request.allowsCellularAccess = true
        
    }
    
    
    func fire() {
        buildRequest()
        buildBody()
        fireTask()
    }
    
    func fireTask() {
        
        task = session.dataTask(with: request as URLRequest, completionHandler: { (data , response, errer) -> Void in
           
            
            if let _ = errer {
           
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.failure(errer! as NSError)
                    
                })
                
            } else {
            
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.success(data!, response!, errer as NSError?)
                    
                })
                
            }
            
            

        })
        
        task.resume()
    }
    
    func buildBody() {
   
        if self.params.count > 0 && self.method != "GET" {
            request.httpBody = buildParams(self.params).data(using: String.Encoding.utf8)
        }
    }
    
   
    func buildRequest() {
   
        if self.method == "GET" && self.params.count>0 {
       
            let tempUrl = url + "?" + buildParams(self.params)
            
            print("\(tempUrl)\n", terminator: "")
            
            self.request = NSMutableURLRequest(url: URL(string: tempUrl)!)
        }
        
        request.httpMethod = self.method
        if self.params.count > 0 {
       
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }

    }
    
    // 从 Alamofire 偷了三个函数
    func buildParams(_ parameters: [String: String?]) -> String {
        var components: [(String, String)] = []
        for key in Array(parameters.keys).sorted(by: <) {
            let value: AnyObject! = parameters[key]! as AnyObject!
            components += queryComponents(key, value)
        }
        
        return (components.map { "\($0)=\($1)" } as [String]).joined(separator: "&")
    }
    
    func queryComponents(_ key: String, _ value: AnyObject) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents("\(key)[]", value)
            }
        } else {
            components.append((escape(key), escape("\(value)")))
        }
        
        return components
    }
    
    func escape(_ string: String) -> String {
        let generalDelimiters = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimiters = "!$&'()*+,;="
        
        let legalURLCharactersToBeEscaped = generalDelimiters + subDelimiters
        
        return CFURLCreateStringByAddingPercentEscapes(nil, string as CFString!, nil, legalURLCharactersToBeEscaped as CFString!, CFStringBuiltInEncodings.UTF8.rawValue) as String
    }
}
