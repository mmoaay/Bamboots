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
    init(container: MBContainable? = nil, mask: MBMaskable? = MBLoading(activityIndicatorStyle: .gray), inset: UIEdgeInsets = UIEdgeInsets.zero) {
        self.inset = inset
        self.mask = mask
        self.container = container
    }
    
    /// 请求开始
    open func begin() {
        show()
    }
    
    /// 请求结束
    open func end() {
        hide()
    }
    
    var inset: UIEdgeInsets
    var mask: MBMaskable?
    var container: MBContainable?
}
