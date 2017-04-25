//
//  Error.swift
//  Pods
//
//  Created by ZhengYidong on 01/01/2017.
//
//

import Foundation
import ObjectMapper

// MARK: - Default extension for `Errorable`
public extension Errorable {
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

/// Error protocol for JSON data. Conforming to this protocol to customize the error configuration for JSON data
public protocol JSONErrorable: Errorable, Mappable {

}

/// Error protocol. Conforming to this protocol to customize the error configuration.
public protocol Errorable {

    /// Using this set with code to distinguish successful code from error code
    var successCodes: [String] { get }

    /// Using this code with successCodes set to distinguish successful code from error code
    var code: String? { get }

    /// Corresponding message
    var message: String? { get }
}
