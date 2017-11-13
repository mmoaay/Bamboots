//
//  UITableViewCell+Bamboots.swift
//  Pods
//
//  Created by ZhengYidong on 17/12/2016.
//
//

import Foundation

// MARK: - Making `UITableViewCell` conforms to `Containable`
extension UITableViewCell {

    /// Return `contentView` as container for `UITableViewCell`
    ///
    /// - Returns: `contentView` of `UITableViewCell`
// TODO: build    public override func containerView() -> UIView? {
//        return self.contentView
//    }
}

// MARK: - Making `UITableViewCell` conforms to `Loadable`
extension UITableViewCell: Loadable {
    public func maskContainer() -> Containable? {
        return self
    }

    public func mask() -> Maskable? {
        let mask = ActivityIndicator()
        mask.backgroundColor = backgroundColor
        mask.color = tintColor
        return mask
    }
}
