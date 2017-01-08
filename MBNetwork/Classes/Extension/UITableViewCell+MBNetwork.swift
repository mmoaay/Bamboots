//
//  UITableViewCell+MBNetwork.swift
//  Pods
//
//  Created by ZhengYidong on 17/12/2016.
//
//

import Foundation

// MARK: - Making `UITableViewCell` conforms to `MBContainable`
extension UITableViewCell {
    
    /// Return `contentView` as container for `UITableViewCell`
    ///
    /// - Returns: `contentView` of `UITableViewCell`
    public override func containerView() -> UIView? {
        return self.contentView
    }
}

// MARK: - Making `UITableViewCell` conforms to `MBLoadable`
extension UITableViewCell: MBLoadable {
    public func maskContainer() -> MBContainable? {
        return self
    }
    
    public func mask() -> MBMaskable? {
        let mask = MBActivityIndicator()
        mask.backgroundColor = backgroundColor
        mask.color = tintColor
        return mask
    }
}
