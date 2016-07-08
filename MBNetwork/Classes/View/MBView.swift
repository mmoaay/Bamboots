//
//  MBView.swift
//  Pods
//
//  Created by Perry on 16/7/7.
//
//

import Foundation

extension UIView {
    func addFullSubView(subview:UIView) {
        
        self.addSubview(subview)
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let views:[String:UIView] = ["subview":subview]
        let layoutStringH:String = "H:|-(" + String(-self.layoutMargins.left) + ")-[subview]-(" + String(-self.layoutMargins.right) + ")-|"
        let layoutStringV:String = "V:|-(" + String(-self.layoutMargins.top) + ")-[subview]-(" + String(-self.layoutMargins.bottom) + ")-|"
        let contraintsH:[NSLayoutConstraint] = NSLayoutConstraint.constraintsWithVisualFormat(layoutStringH, options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: views)
        let contraintsV:[NSLayoutConstraint] = NSLayoutConstraint.constraintsWithVisualFormat(layoutStringV, options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: views)
        
        self.addConstraints(contraintsH)
        self.addConstraints(contraintsV)
    }
}