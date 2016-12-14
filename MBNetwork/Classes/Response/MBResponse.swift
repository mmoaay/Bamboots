//
//  MBResponse.swift
//  Pods
//
//  Created by ZhengYidong on 9/13/16.
//
//

import Foundation
import ObjectMapper

public protocol MBSerializable {
    
    /// 数据节点名
    var data:String? { get }
    
    /// 错误码节点名
    var code:String? { get }
    
    /// 错误信息节点名
    var message:String? { get }
}
