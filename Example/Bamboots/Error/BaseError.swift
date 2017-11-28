//
//  BaseError.swift
//  Bamboots
//
//  Created by ZhengYidong on 29/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Bamboots

struct BaseError: JSONErrorable {
    var successCodes: [String] = ["https://httpbin.org/post"]

    var code: String?
    var message: String?
    
    enum CodingKeys : String, CodingKey {
        case code = "url"
        case message = "origin"
    }
}
