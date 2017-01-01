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
    @discardableResult
    public func alert<T: MBServerErrorable>(error: T? = nil, alert: MBAlertable = MBAlertType.none, completionHandler: ((MBServerErrorable) -> Void)? = nil) -> Self {

        return response(completionHandler: { (response:DefaultDataResponse) in
            if let error = response.error {
                alert.show(error: error.localizedDescription)
            }
        }).responseObject(queue: nil, keyPath: nil, mapToObject: nil, context: nil, completionHandler: { (response:DataResponse<T>) in
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
    
    @discardableResult
    public func responseObject<T: BaseMappable>(queue: DispatchQueue? = nil, serialize: MBSerializable? = nil, mapToObject object: T? = nil, context: MapContext? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: DataRequest.ObjectMapperSerializer(serialize?.dataNode, mapToObject: object, context: context), completionHandler: completionHandler)
    }
    
    @discardableResult
    public func load(load: MBLoadable = MBLoadType.none) -> Self {
        load.begin()
        return response(completionHandler: { (response:DefaultDataResponse) in
            load.end()
        })
    }
}


extension DownloadRequest {
    @discardableResult
    public func progress(progress: MBLoadProgressable? = nil) -> Self {
        return downloadProgress(closure: { (prog: Progress) in
            progress?.progress(prog)
        })
    }
}

extension UploadRequest {
    @discardableResult
    public func progress(progress: MBLoadProgressable? = nil) -> Self {
        return uploadProgress(closure: { (prog: Progress) in
            progress?.progress(prog)
        })
    }
}
