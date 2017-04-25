//
//  LoadConfig.swift
//  Bamboots
//
//  Created by ZhengYidong on 15/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Bamboots

class LoadConfig: Loadable {
    init(container: Containable? = nil, mask: Maskable? = MaskView(), inset: UIEdgeInsets = UIEdgeInsets.zero) {
        insetMine = inset
        maskMine = mask
        containerMine = container
    }

    func mask() -> Maskable? {
        return maskMine
    }

    func inset() -> UIEdgeInsets {
        return insetMine
    }

    func maskContainer() -> Containable? {
        return containerMine
    }

    func begin() {
        show()
    }

    func end() {
        hide()
    }

    var insetMine: UIEdgeInsets
    var maskMine: Maskable?
    var containerMine: Containable?
}
