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

    var url = "http://img.tuku.com/upload/attach/2013/07/98031-9wo1TE2.jpg"
}
