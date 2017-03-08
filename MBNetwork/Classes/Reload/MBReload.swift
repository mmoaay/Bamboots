//
//  MBReload.swift
//  Pods
//
//  Created by zhengperry on 2017/1/1.
//
//

import Foundation

public protocol MBReloadOperatable {
    func reloadMask() -> MBMaskable?
    
    var reload: () -> Void { get }
}

public protocol MBReloadable {
    func reloadContainer() -> MBContainable?
    
    func reloadOperator() -> MBReloadOperatable?
}
