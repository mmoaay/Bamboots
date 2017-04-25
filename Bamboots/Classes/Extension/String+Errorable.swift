//
//  String+Bamboots.swift
//  Pods
//
//  Created by ZhengYidong on 01/01/2017.
//
//

import Foundation

// MARK: - Making `String` conforms to `Errorable`
extension String: Errorable {
    public var message: String? {
        return self
    }
}
