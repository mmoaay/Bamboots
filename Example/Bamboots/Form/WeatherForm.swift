//
//  BaiduGeoCoderForm.swift
//  Bamboots
//
//  Created by Perry on 16/7/8.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import Foundation
import Bamboots
import Alamofire

struct WeatherForm: RequestFormable {
    var city = "shanghai"

    func parameters() -> [String: Any] {
        return ["city": city]
    }

    var url = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/"
        + "2ee8f34d21e8febfdefb2b3a403f18a43818d70a/sample_keypath_json"
}
