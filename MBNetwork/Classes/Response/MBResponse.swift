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
    var dataNode:String? { get }
    
    /// 错误节点名
    var errorNode:String? { get }
}
