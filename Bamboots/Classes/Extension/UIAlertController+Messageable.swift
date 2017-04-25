//
//  UIAlertController+Messageable.swift
//  Pods
//
//  Created by zhengperry on 2017/2/5.
//
//

import Foundation

extension UIAlertController: Informable {
    public func show() {
        UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
    }
}

extension UIAlertController: Warnable{
    public func show(error: Errorable?) {
        if let err = error {
            if "" != err.message {
                message = err.message
                
                UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
            }
        }
    }
}
