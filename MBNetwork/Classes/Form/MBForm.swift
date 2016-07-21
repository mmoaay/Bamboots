//
//  MBForm.swift
//  Pods
//
//  Created by Perry on 16/7/7.
//
//

import Foundation
import Alamofire

// MARK: - MBFormable

/**
 实现 MBFormable 协议的类型可以做为请求网络时候的参数
 - 实现 url 指定请求地址
 - 实现 parameters 设置请求参数
 - 实现 method 设置请求方式
 - 实现 id 设置请求编号，如：GET_USER_INFO (注：开发者需要保证请求ID的唯一性)
 */

public protocol MBFormable {
    var url:String { get }
    
    var parameters:Dictionary<String, String> { get }
    
    var method:Alamofire.Method { get }
    
    var id:String { get }
}
