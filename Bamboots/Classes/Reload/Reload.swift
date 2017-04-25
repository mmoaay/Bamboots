//
//  Reload.swift
//  Pods
//
//  Created by zhengperry on 2017/1/1.
//
//

import Foundation

public protocol ReloadOperatable {
    func reloadMask() -> Maskable?
    
    var reload: () -> Void { get }
}

public protocol Reloadable {
    func reloadContainer() -> Containable?
    
    func reloadOperator() -> ReloadOperatable?
}
