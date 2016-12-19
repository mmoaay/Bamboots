//
//  UITableViewCell+MBExtension.swift
//  Pods
//
//  Created by ZhengYidong on 17/12/2016.
//
//

import Foundation

extension UITableViewCell {
    public override func container() -> UIView? {
        return self.contentView
    }
}
