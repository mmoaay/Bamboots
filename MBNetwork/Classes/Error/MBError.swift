//
//  MBError.swift
//  Pods
//
//  Created by ZhengYidong on 01/01/2017.
//
//

import Foundation
import ObjectMapper

extension MBErrorable {
    public var successCodes: [String] {
        return []
    }
    
    public var code: String? {
        return nil
    }
    
    public var message: String? {
        return nil
    }
}

public protocol MBServerErrorable: MBErrorable, Mappable {
    
}

public protocol MBErrorable {
    var successCodes: [String] { get }
    
    var code: String? { get }
    var message: String? { get }
}
