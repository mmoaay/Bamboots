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
    var url = "http://api.map.baidu.com/geocoder/v2/"
    var parameters = ["address":"北京市海淀区上地十街10号", "output":"json", "ak":"E4805d16520de693a3fe707cdc962045", "callback":"showLocation"]
    var method = Alamofire.Method.POST
    
    init (){
        self.parameters = ["address":"北京市海淀区上地十街10号", "output":"json", "ak":"E4805d16520de693a3fe707cdc962045", "callback":"showLocation"]
    }
}
