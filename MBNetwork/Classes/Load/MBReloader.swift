//
//  MBReloader.swift
//  Pods
//
//  Created by Perry on 16/7/8.
//
//

import Foundation

extension MBReloadConfig {
    var loadConfig : MBReloadConfig? {
        return self
    }
}

public class MBReloadConfig {
    
    var mask:UIView
    var container:UIView
    var insets:UIEdgeInsets
    
    internal var count = 1
    
    var id:String
    
    
    public init(id:String = "MBLOAD_CONFIG_DEFAULT", mask:UIView = MBLoading.loading(), container:UIView, insets:UIEdgeInsets = UIEdgeInsetsZero) {
        self.mask = mask
        self.container = container
        self.insets = insets
        self.id = id
    }
}

public protocol MBReloadable {
    func reload()
    
    var loadConfig : MBReloadConfig? { get }
}