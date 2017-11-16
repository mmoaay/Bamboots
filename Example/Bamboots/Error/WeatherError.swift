//
//  WeatherError.swift
//  Bamboots
//
//  Created by ZhengYidong on 03/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Bamboots

class WeatherError: JSONErrorable {
    var successCodes: [String] = ["200"]

    var code: String?
    var message: String?
    
    enum CodingKeys : String, CodingKey {
        case code = "data.loacation"
        case message = "data.location"
    }
}

class WeatherInformError: JSONErrorable {
    var successCodes: [String] = ["Toronto, Canada"]

    var code: String?
    var message: String?

//    init() { }
//
//    required init?(map: Map) { }
//
//    func mapping(map: Map) {
//        code <- map["data.location"]
//        message <- map["data.location"]
//    }
}
