//
//  Error.swift
//  Pods
//
//  Created by ZhengYidong on 01/01/2017.
//
//

import Foundation

// MARK: - Default extension for `Errorable`
public extension Errorable {
    var successCodes: [String] {
        return []
    }
    
    var rootPath: String? {
        return nil
    }

    var code: String? {
        return nil
    }

    var message: String? {
        return nil
    }
}

/// Error protocol for JSON data. Conforming to this protocol to customize the error configuration for JSON data
public protocol JSONErrorable: Errorable, Codable {

}

/// Error protocol. Conforming to this protocol to customize the error configuration.
public protocol Errorable {
    var rootPath: String? { get }

    /// Using this set with code to distinguish successful code from error code
    var successCodes: [String] { get }

    /// Using this code with successCodes set to distinguish successful code from error code
    var code: String? { get }

    /// Corresponding message
    var message: String? { get }
}
