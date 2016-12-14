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
    var word = "word"
    
    public func parameters() -> [String : Any] {
        return ["word":word]
    }

    var url = "https://httpbin.org/get"
    var method = Alamofire.HTTPMethod.get
}
