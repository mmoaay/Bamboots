//
//  Message.swift
//  Pods
//
//  Created by Perry on 16/8/9.
//
//

import Foundation
import ObjectMapper
import Alamofire

public extension Informable {
    func message() -> String {
        return "Successfully"
    }
}

/// Inform protocol. Conforming to this protocol to customize the way of inform messages displayed when request done successfully
public protocol Informable: Messageable {
    func show()

    func message() -> String
}

/// Warn protocol. Conforming to this protocol to customize the way of warning messages displayed when error occured
public protocol Warnable: Messageable {
    func show(error: Errorable?)
}

public extension Messageable {
    func messageContainer() -> Containable? {
        return nil
    }
}

/// Message protocol
public protocol Messageable {
    func messageContainer() -> Containable?
}
