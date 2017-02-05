//
//  MBMessage.swift
//  Pods
//
//  Created by Perry on 16/8/9.
//
//

import Foundation
import ObjectMapper
import Alamofire

public extension MBInformable {
    func message() -> String {
        return "Successfully"
    }
}

/// Inform protocol. Conforming to this protocol to customize the way of inform messages displayed when request done successfully
public protocol MBInformable: MBMessageable {
    func show()

    func message() -> String
}

/// Warn protocol. Conforming to this protocol to customize the way of warning messages displayed when error occured
public protocol MBWarnable: MBMessageable {
    func show(error: MBErrorable?)
}

public extension MBMessageable {
    func messageContainer() -> MBContainable? {
        return nil
    }
}

/// Message protocol
public protocol MBMessageable {
    func messageContainer() -> MBContainable?
}
