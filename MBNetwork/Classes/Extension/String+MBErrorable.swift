//
//  String+MBNetwork.swift
//  Pods
//
//  Created by ZhengYidong on 01/01/2017.
//
//

import Foundation

// MARK: - Making `String` conforms to `MBErrorable`
extension String: MBErrorable {
    public var message: String? {
        return self
    }
}
