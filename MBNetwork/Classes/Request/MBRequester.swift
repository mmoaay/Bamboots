//
//  MBRequester.swift
//  Pods
//
//  Created by Perry on 16/7/6.
//
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

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
    public func send(_ form:MBFormable, load:MBLoadable = MBLoadType.none, reload:MBReloadable = MBReloadType.none)  {
        
        showLoad(load)
        
        Alamofire.request(form.url, method: form.method, parameters: form.parameters(), encoding: form.encoding(), headers: form.headers()).responseJSON { (data:DataResponse<Any>) in
            self.hideLoad(load)
        }
    }
}

// MARK: - MBRequestable

/**
 满足 MBRequestable 协议的类型可以进行网络请求
 */
public protocol MBRequestable : class{
    
}




