//
//  UploadForm.swift
//  MBNetwork
//
//  Created by ZhengYidong on 01/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import MBNetwork
import Alamofire

struct UploadForm: MBUploadMultiFormDataFormable {
    var multipartFormData: (MultipartFormData) -> Void = { multipartFormData in
//        multipartFormData.append(, withName: "unicorn")
//        multipartFormData.append("", withName: "rainbow")
    }
    
    /// request url
    var url: String  = "https://httpbin.org/post"
}
