//
//  MBBaseSuccess.swift
//  MBNetwork
//
//  Created by zhengperry on 2017/1/2.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import Foundation
import MBNetwork
import ObjectMapper

class MBBaseSuccess: MBServerErrorable {
    var successCodes: [String] = [""]
    
    var code: String?
    var message: String?
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        code <- map["data.location"]
        message <- map["data.location"]
    }
}

