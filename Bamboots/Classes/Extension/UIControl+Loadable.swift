//
//  UIControl+Loadable.swift
//  Pods
//
//  Created by ZhengYidong on 08/01/2017.
//
//

import Foundation

// MARK: - Making `UIControl` conforms to `Loadable`
extension UIControl: Loadable {

    public func maskContainer() -> Containable? {
        return self
    }

    public func mask() -> Maskable? {
        let mask = ActivityIndicator()
        mask.backgroundColor = backgroundColor
        mask.color = tintColor
        return mask
    }

    /// Making it disabled when network request begins
    public func begin() {
        isEnabled = false
        show()
    }

    /// Making it enabled when the last network request ends
    public func end() {
        if let latestMask = self.maskContainer()?.latestMask() {
            if false == latestMask.isHidden {
                isEnabled = true
            }
        }
        hide()
    }
}
