//
//  MBLoadConfig.swift
//  MBNetwork
//
//  Created by ZhengYidong on 15/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import MBNetwork

class MBLoadConfig: MBLoadable {
    init(container: MBContainable? = nil, mask: MBMaskable? = MBMaskView(), inset: UIEdgeInsets = UIEdgeInsets.zero) {
        insetMine = inset
        maskMine = mask
        containerMine = container
    }
    
    func mask() -> MBMaskable? {
        return maskMine
    }
    
    func inset() -> UIEdgeInsets {
        return insetMine
    }
    
    func maskContainer() -> MBContainable? {
        return containerMine
    }
    
    /// 请求开始
    func begin() {
        show()
    }
    
    /// 请求结束
    func end() {
        hide()
    }
    
    var insetMine: UIEdgeInsets
    var maskMine: MBMaskable?
    var containerMine: MBContainable?
}
