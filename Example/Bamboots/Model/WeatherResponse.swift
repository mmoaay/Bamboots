//
//  JSONModel.swift
//  Bamboots
//
//  Created by ZhengYidong on 29/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Bamboots

class WeatherResponse: Codable {
    
    var location: String?
    var threeDayForecast: [Forecast]?
    
    enum CodingKeys : String, CodingKey {
        case location
        case threeDayForecast = "three_day_forecast"
    }
}

class Forecast: Codable {
    
    var day: String?
    var temperature: Int?
    var conditions: String?
    
}
