//
//  MBError.swift
//  Pods
//
//  Created by ZhengYidong on 01/01/2017.
//
//

import Foundation
import ObjectMapper

public extension MBErrorable {
    var successCodes: [String] {
        return []
    }
    
    var code: String? {
        return nil
    }
    
    var message: String? {
        return nil
    }
}

public protocol MBServiceErrorable: MBErrorable, Mappable {
    
}

public protocol MBErrorable {
    
    /// If the code returns from the service exsists in this set, then it means the request is completed successfully.
    var successCodes: [String] { get }
    
    /// The code returns form the service
    var code: String? { get }
    
    /// Corresponding message from the service
    var message: String? { get }
}
