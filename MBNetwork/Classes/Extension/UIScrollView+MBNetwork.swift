//
//  UIScrollView+MBNetwork.swift
//  Pods
//
//  Created by ZhengYidong on 15/12/2016.
//
//

import Foundation

extension UIScrollView {
    override public func container() -> UIView? {
        return self.superview
    }
}
