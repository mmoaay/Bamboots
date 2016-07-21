//
//  MBRequester.swift
//  Pods
//
//  Created by Perry on 16/7/6.
//
//

import UIKit
import SwiftyJSON
import Alamofire

public extension MBRequestable  {
    // MARK: - send 方法
    
    /**
     Creates a request using the shared manager instance for the specified method, URL string, parameters, and
     parameter encoding.
     
     - parameter method:     The HTTP method.
     - parameter URLString:  The URL string.
     - parameter parameters: The parameters. `nil` by default.
     - parameter encoding:   The parameter encoding. `.URL` by default.
     - parameter headers:    The HTTP headers. `nil` by default.
     
     - returns: The created request.
     */
    public func send(form:MBFormable, load:MBLoadable)  {
        
        if let loadable = self as? MBLoadable {
            loadable.showLoad(loadType)
        }
        
        Alamofire.request(form.method, form.url, parameters: form.parameters).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    if let loadable = self as? MBLoadable {
                        loadable.hideLoad(loadType)
                    }
                }
            case .Failure(let error):
                print(error)
                
                if let loadable = self as? MBLoadable {
                    loadable.hideLoad(loadType)
                }
            }
        }
    }
}

// MARK: - MBRequestable

/**
 满足 MBRequestable 协议的类型可以进行网络请求
 */
public protocol MBRequestable : class{
    
}




