//
//  UIViewController+MBExtension.swift
//  Pods
//
//  Created by ZhengYidong on 14/12/2016.
//
//

import Foundation

extension UIViewController: MBContainable {
    public func containerView() -> UIView {
        return self.view
    }
}
