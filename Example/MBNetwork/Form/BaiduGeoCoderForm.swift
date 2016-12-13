//
//  BaiduGeoCoderForm.swift
//  MBNetwork
//
//  Created by Perry on 16/7/8.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import Foundation
import MBNetwork
import Alamofire

struct BaiduGeoCoderForm :MBFormable {
    
    public func parameters() -> [String : Any] {
        return [:]
    }

    var url = "https://httpbin.org/get"
    var method = Alamofire.HTTPMethod.get
}
