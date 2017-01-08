//
//  MBReload.swift
//  Pods
//
//  Created by zhengperry on 2017/1/1.
//
//

import Foundation

public protocol MBReloadable {
    var container: MBContainable? { get }

    func reload(error: MBErrorable)
}
