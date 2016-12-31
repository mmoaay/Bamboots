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

public protocol MBSerializable {
    var dataNode: String? { get }
}

extension DataRequest {
    public func alert<T: MBErrorable>(queue: DispatchQueue? = nil, error: T, alert: MBAlertable = MBAlertType.none, completionHandler: ((MBErrorable) -> Void)? = nil) -> Self {

        return responseObject(queue: queue, keyPath: nil, mapToObject: nil, context: nil, completionHandler: { (response:DataResponse<T>) in
            if let error = response.result.value {
                if let code = error.code {
                    if true == error.successCodes.contains(code) {
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
    
    public func responseObject<T: BaseMappable>(queue: DispatchQueue? = nil, serialize: MBSerializable? = nil, mapToObject object: T? = nil, context: MapContext? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: DataRequest.ObjectMapperSerializer(serialize?.dataNode, mapToObject: object, context: context), completionHandler: completionHandler)
    }
}


extension DownloadRequest {
    public func progress(progress: MBLoadProgressable? = nil) -> Self {
        return downloadProgress(closure: { (prog: Progress) in
            progress?.progress(prog)
        })
    }
}

extension UploadRequest {
    public func progress(progress: MBLoadProgressable? = nil) -> Self {
        return uploadProgress(closure: { (prog: Progress) in
            progress?.progress(prog)
        })
    }
}
