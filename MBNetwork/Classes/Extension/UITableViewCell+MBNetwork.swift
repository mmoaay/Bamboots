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
    public override func container() -> UIView? {
        return self.contentView
    }
}
