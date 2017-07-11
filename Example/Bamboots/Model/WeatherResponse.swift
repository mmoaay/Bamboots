//
//  JSONModel.swift
//  Bamboots
//
//  Created by ZhengYidong on 29/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Bamboots
import ObjectMapper

import RealmSwift

class WeatherResponse: Mappable, CacheMappable {
    typealias ObjectType = WeatherCache
    
    var location: String?
    var threeDayForecast: [Forecast]?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        location <- map["location"]
        threeDayForecast <- map["three_day_forecast"]
    }
    
    func encode() -> WeatherCache {
    }
    
    func decode(object:WeatherCache) {
        
    }
}

class Forecast: Mappable {
    var day: String?
    var temperature: Int?
    var conditions: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        day <- map["day"]
        temperature <- map["temperature"]
        conditions <- map["conditions"]
    }
}

class WeatherCache: Object {
    dynamic var location: String?
    let threeDayForecast = List<ForecastCache>()
}

class ForecastCache: Object {
    dynamic var day: String?
    dynamic var temperature: String?
    dynamic var conditions: String?
}
