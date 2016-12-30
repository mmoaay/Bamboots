//
//  MBResponse.swift
//  Pods
//
//  Created by ZhengYidong on 9/13/16.
//
//

import Foundation
import Alamofire
import ObjectMapper

extension DataRequest {
    public func error<T: MBErrorSerializable>(queue: DispatchQueue? = nil, config: MBErrorConfigurable, serialize: T.Type, alert: MBAlertable = MBAlertType.none, completionHandler: ((MBErrorSerializable) -> Void)? = nil) -> Self {

        return responseObject(queue: queue, keyPath: config.node, mapToObject: nil, context: nil, completionHandler: { (response:DataResponse<T>) in
            if let error = response.result.value {
                if let code = error.code {
                    if true == config.codes.contains(code) {
                        if let completion = completionHandler {
                            completion(error)
                        }
                    } else {
                        alert.show(error: error)
                    }
                }
            }
        })
    }
}


extension DownloadRequest {
    public func progress(progress: MBLoadProgressable? = nil) -> Self {
        return downloadProgress(closure: { (prog:Progress) in
            progress?.progress(prog)
        })
    }
}
