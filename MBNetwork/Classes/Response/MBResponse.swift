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

public extension DataRequest {
    @discardableResult
    func alert<T: MBServerErrorable>(error: T? = nil, alert: MBAlertable = MBAlertType.none, completionHandler: ((MBServerErrorable) -> Void)? = nil) -> Self {

        return response(completionHandler: { (response:DefaultDataResponse) in
            if let error = response.error {
                alert.show(error: error.localizedDescription)
            }
        }).responseObject(queue: nil, keyPath: nil, mapToObject: nil, context: nil, completionHandler: { (response:DataResponse<T>) in
            if let error = response.result.value {
                if let code = error.code {
                    if true == error.successCodes.contains(code) {
                        completionHandler?(error)
                    } else {
                        alert.show(error: error)
                    }
                }
            }
        })
    }
    
    func inform<T: MBServerErrorable>(success: T? = nil, inform: MBInformable = MBInformType.none) -> Self {
        
        return responseObject(queue: nil, keyPath: nil, mapToObject: nil, context: nil, completionHandler: { (response:DataResponse<T>) in
            if let error = response.result.value {
                if let code = error.code {
                    if true == error.successCodes.contains(code) {
                        inform.show()
                    }
                }
            }
        })
    }
    
    @discardableResult
    func responseObject<T: BaseMappable>(queue: DispatchQueue? = nil, serialize: MBSerializable? = nil, mapToObject object: T? = nil, context: MapContext? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: DataRequest.ObjectMapperSerializer(serialize?.dataNode, mapToObject: object, context: context), completionHandler: completionHandler)
    }
    
    @discardableResult
    func load(load: MBLoadable = MBLoadType.none) -> Self {
        load.begin()
        return response(completionHandler: { (response:DefaultDataResponse) in
            load.end()
        })
    }
}


public extension DownloadRequest {
    @discardableResult
    func progress(progress: MBLoadProgressable? = nil) -> Self {
        return downloadProgress(closure: { (prog: Progress) in
            progress?.progress(prog)
        })
    }
}

public extension UploadRequest {
    @discardableResult
    func progress(progress: MBLoadProgressable? = nil) -> Self {
        return uploadProgress(closure: { (prog: Progress) in
            progress?.progress(prog)
        })
    }
}
