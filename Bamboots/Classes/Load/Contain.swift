//
//  Container.swift
//  Pods
//
//  Created by ZhengYidong on 14/12/2016.
//
//

import Foundation

/// Container protocol for `Loadable`, Objects conforms to this protocol can be used as container for the mask
public protocol Containable {
    func containerView() -> UIView?
}

public extension Containable {
    /// Get latest mask on container
    ///
    /// - Returns: If exists, return latest mask, otherwise return nil
    internal func latestMask() -> UIView? {
        var latestMask: UIView? = nil
        if let container = containerView() {
            for subview in container.subviews {
                if let _ = subview as? Maskable {
                    latestMask = subview
                }
            }
        }
        return latestMask
    }
}
