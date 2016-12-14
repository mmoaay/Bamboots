//
//  MBContainer.swift
//  Pods
//
//  Created by ZhengYidong on 14/12/2016.
//
//

import Foundation

public protocol MBContainable {
    func containerView() -> UIView
}


extension MBContainable:MBLoadable {
    
}
