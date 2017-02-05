//
//  UIAlertController+MBMessageable.swift
//  Pods
//
//  Created by zhengperry on 2017/2/5.
//
//

import Foundation

extension UIAlertController: MBInformable {
    public func show() {
        UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
    }
}

extension UIAlertController: MBWarnable{
    public func show(error: MBErrorable?) {
        if let err = error {
            if "" != err.message {
                message = err.message
                
                UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
            }
        }
    }
}
