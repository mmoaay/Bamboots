//
//  UIViewController+MBNetwork.swift
//  Pods
//
//  Created by ZhengYidong on 14/12/2016.
//
//

import Foundation

// MARK: - Making `UIViewController` conforms to `MBContainable`
extension UIViewController: MBContainable {

    /// Return `view` as container for `UIViewController`
    ///
    /// - Returns: `view` of `UIViewController`
    public func containerView() -> UIView? {
        return self.view
    }
}
