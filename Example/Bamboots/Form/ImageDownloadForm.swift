//
//  ImageDownloadForm.swift
//  Bamboots
//
//  Created by ZhengYidong on 26/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Bamboots
import Alamofire

struct ImageDownloadForm: DownloadFormable {

    var destination: DownloadRequest.DownloadFileDestination = { _, _ in
        var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("pig.png")
        return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
    }

    var url = "https://www.google.com.hk/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"
}
