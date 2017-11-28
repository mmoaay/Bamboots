//
//  WeatherError.swift
//  Bamboots
//
//  Created by ZhengYidong on 03/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Bamboots

struct WeatherError: JSONErrorable {
    var rootPath: String? = "data"
    var successCodes: [String] = ["200"]

    var code: String?
    var message: String?
    
    enum CodingKeys : String, CodingKey {
        case code = "location"
        case message = "lacation"
    }
}

struct WeatherInformError: JSONErrorable {
    var rootPath: String? = "data"
    
    var successCodes: [String] = ["Toronto, Canada"]

    var code: String?
    var message: String?
    
    enum CodingKeys : String, CodingKey {
        case code = "location"
        case message = "lacation"
    }
}
