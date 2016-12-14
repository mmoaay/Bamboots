//
//  MBMask.swift
//  Pods
//
//  Created by ZhengYidong on 14/12/2016.
//
//

import Foundation

public protocol MBMaskable {
    var maskId:String { get }
    
    func maskView() -> UIView
}
