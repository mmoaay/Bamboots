//
//  UIButton+MBNetwork.swift
//  Pods
//
//  Created by ZhengYidong on 15/12/2016.
//
//

import Foundation


// MARK: - Making UIButton conforms to MBLoadable
extension UIButton:MBLoadable {
    
    /// Self as container
    open var container:MBContainable? {
        return self
    }
    
    
    /// Making disabled when network request begins
    open func begin() {
        isEnabled = false
        show()
    }
    
    /// Making enabled when the last network request ends
    open func end() {
        if let latestMask = self.container?.latestMask() {
            if false == latestMask.isHidden {
                isEnabled = true
            }
        }
        hide()
    }
}
