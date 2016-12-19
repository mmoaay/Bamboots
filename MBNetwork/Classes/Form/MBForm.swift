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
public extension MBFormable {
    
    /// 实现默认编码方式
    ///
    /// - Returns: Alamofire 默认 URLEncoding
    func encoding() -> ParameterEncoding {
        return Alamofire.URLEncoding.default
    }
}


/// 请求协议
public protocol MBFormable {
    /// 请求 url
    var url: String { get }
    
    /// 请求方式
    var method: Alamofire.HTTPMethod { get }
    
    
    /// 请求头
    ///
    /// - Returns: 请求头
    func headers() -> [String: String]
    
    /// 编码方式
    ///
    /// - Returns: 编码方式
    func encoding() -> ParameterEncoding
    
    /// 请求参数
    ///
    /// - Returns: 请求参数
    func parameters() -> [String: Any]
}
