//
//  MBReloader.swift
//  Pods
//
//  Created by Perry on 16/7/8.
//
//

import Foundation

typealias reload = ()->Void

extension MBReloadConfig:MBReloadable {
    public var reloadConfig : MBReloadConfig? {
        return self
    }
}

extension MBReloadType:MBReloadable {
    public var reloadConfig : MBReloadConfig? {
        switch self {
        case .Default(let container):
            return MBReloadConfig(container:container)
        case .None:
            return nil
        }
    }
}

public enum MBReloadType {
    case None
    case Default(container:UIView)
}

public class MBReloadConfig {
    
    var mask:UIView
    var container:UIView
    var insets:UIEdgeInsets
    
    var id:String
    
    
    public init(id:String = "MBLOAD_CONFIG_DEFAULT", mask:UIView = MBLoading.loading(), container:UIView, insets:UIEdgeInsets = UIEdgeInsetsZero) {
        self.mask = mask
        self.container = container
        self.insets = insets
        self.id = id
    }
}

public protocol MBReloadable  {
    var reloadConfig : MBReloadConfig? { get }
}