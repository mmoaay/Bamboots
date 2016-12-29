//
//  MBError.swift
//  MBNetwork
//
//  Created by ZhengYidong on 29/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import MBNetwork
import ObjectMapper

class MBErrorConfig: MBErrorConfigurable {
    var node: String? = "data"
    
    var codes: [String] = ["200"]
}

class MBErrorSerialize: MBErrorSerializable {
    var code: String?
    var message: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        code <- map["location"]
        message <- map["location"]
    }
}
