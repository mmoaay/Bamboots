//
//  MBMask.swift
//  Pods
//
//  Created by ZhengYidong on 14/12/2016.
//
//

import Foundation

/// Mask protocol for MBLoadable, View that conforms to this protocol will be treated as mask
public protocol MBMaskable {
    var maskId: String { get }
}
