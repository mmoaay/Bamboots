//
//  UITableViewCell+MBNetwork.swift
//  Pods
//
//  Created by ZhengYidong on 17/12/2016.
//
//

import Foundation

// MARK: - Making UITableViewCell conforms to MBContainable
extension UITableViewCell {
    
    /// Return contentView as container for UITableViewCell
    ///
    /// - Returns: ContentView of UITableViewCell
    public override func containerView() -> UIView? {
        return self.contentView
    }
}

extension UITableViewCell: MBLoadable {
    public func maskContainer() -> MBContainable? {
        return self
    }
    
    public func mask() -> MBMaskable? {
        return MBActivityIndicator()
    }
}
