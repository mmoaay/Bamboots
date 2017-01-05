//
//  WeatherError.swift
//  MBNetwork
//
//  Created by ZhengYidong on 03/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import MBNetwork
import ObjectMapper

class WeatherError: MBServiceErrorable {
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

class WeatherInformError: MBServiceErrorable {
    var successCodes: [String] = ["Toronto, Canada"]
    
    var code: String?
    var message: String?
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        code <- map["data.location"]
        message <- map["data.location"]
    }
}
