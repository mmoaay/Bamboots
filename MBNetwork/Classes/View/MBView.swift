//
//  MBView.swift
//  Pods
//
//  Created by Perry on 16/7/7.
//
//

import Foundation

extension UIView {
    func addMBSubView(subview:UIView, insets:UIEdgeInsets) {
        
        self.addSubview(subview)
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let views:[String:UIView] = ["subview":subview]
        let layoutStringH:String = "H:|-" + String(insets.left) + "-[subview]-" + String(insets.right) + "-|"
        let layoutStringV:String = "V:|-" + String(insets.top) + "-[subview]-" + String(insets.bottom) + "-|"
        let contraintsH:[NSLayoutConstraint] = NSLayoutConstraint.constraintsWithVisualFormat(layoutStringH, options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: views)
        let contraintsV:[NSLayoutConstraint] = NSLayoutConstraint.constraintsWithVisualFormat(layoutStringV, options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: views)
        
        self.addConstraints(contraintsH)
        self.addConstraints(contraintsV)
    }
}