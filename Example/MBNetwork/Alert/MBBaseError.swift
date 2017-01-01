//
//  MBBaseError.swift
//  MBNetwork
//
//  Created by ZhengYidong on 29/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import MBNetwork
import ObjectMapper

class MBBaseError: MBServerErrorable {
    var successCodes: [String] = ["200"]
    
    var code: String?
    var message: String?
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        code <- map["data.location"]
        message <- map["data.location"]
    }
}

