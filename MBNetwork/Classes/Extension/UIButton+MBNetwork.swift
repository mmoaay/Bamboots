//
//  UIButton+MBNetwork.swift
//  Pods
//
//  Created by ZhengYidong on 15/12/2016.
//
//

import Foundation

extension UIButton:MBLoadable {
    open var container:MBContainable? {
        return self
    }
    
    /// 请求开始
    open func begin() {
        isEnabled = false
        show()
    }
    
    /// 请求结束
    open func end() {
        if let latestMask = self.container?.latestMask() {
            if false == latestMask.isHidden {
                isEnabled = true
            }
        }
        hide()
    }
}
