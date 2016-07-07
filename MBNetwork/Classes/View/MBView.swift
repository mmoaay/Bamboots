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
        
        let views:[String:UIView] = ["subview":subview]
        let layoutStringH:String = "|-0-[subview]-0-|"
        let layoutStringV:String = "V:|-0-[subview]-0-|"
        let contraintsH:[NSLayoutConstraint] = NSLayoutConstraint.constraintsWithVisualFormat(layoutStringH, options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: views)
        let contraintsV:[NSLayoutConstraint] = NSLayoutConstraint.constraintsWithVisualFormat(layoutStringV, options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: views)
        
        self.addConstraints(contraintsH)
        self.addConstraints(contraintsV)
    }
}