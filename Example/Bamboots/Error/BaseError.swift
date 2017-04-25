//
//  BaseError.swift
//  Bamboots
//
//  Created by ZhengYidong on 29/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Bamboots
import ObjectMapper

class BaseError: JSONErrorable {
    var successCodes: [String] = ["https://httpbin.org/post"]

    var code: String?
    var message: String?

    init() { }

    required init?(map: Map) { }

    func mapping(map: Map) {
        code <- map["url"]
        message <- map["origin"]
    }
}
