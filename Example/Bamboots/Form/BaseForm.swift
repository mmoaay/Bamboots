//
//  BaseForm.swift
//  Bamboots
//
//  Created by ZhengYidong on 13/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Bamboots

extension Formable {
    public func headers() -> [String: String] {
        return ["accessToken": "xxx"]
    }
}

extension Formable where Self: UploadFormable {
    public func headers() -> [String: String] {
        return ["accessToken": "xxx", "fileName": "xxx"]
    }
}
