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

public extension DataRequest {
    
    /// Show warning message when error occurs
    ///
    /// - Parameters:
    ///   - error: Object conforms to MBJSONErrorable protocol, used for serializing error data from service
    ///   - warn: Object conforms to MBWarnable protocol, used for show warning message when error occurs
    ///   - completionHandler: The code to be executed once the error code exsists in error's success codes
    /// - Returns: The request.
    @discardableResult
    func warn<T: MBJSONErrorable>(error: T, warn: MBWarnable = MBMessageType.none, completionHandler: ((MBJSONErrorable) -> Void)? = nil) -> Self {

        return response(completionHandler: { (response:DefaultDataResponse) in
            if let err = response.error {
                warn.show(error: err.localizedDescription)
            }
        }).responseObject(queue: nil, keyPath: nil, mapToObject: nil, context: nil) { (response:DataResponse<T>) in
            if let err = response.result.value {
                if let code = err.code {
                    if true == error.successCodes.contains(code) {
                        completionHandler?(err)
                    } else {
                        warn.show(error: err)
                    }
                }
            }
        }
    }
    
    
    /// Show inform message when request completed successfully
    ///
    /// - Parameters:
    ///   - error: Object conforms to MBJSONErrorable protocol, used for serializing error data from service
    ///   - inform: Object conforms to MBInformable protocol, used for show inform message when request completed successfully
    /// - Returns: The request.
    @discardableResult
    func inform<T: MBJSONErrorable>(error: T, inform: MBInformable = MBMessageType.none) -> Self {
        
        return responseObject(queue: nil, keyPath: nil, mapToObject: nil, context: nil) { (response:DataResponse<T>) in
            if let err = response.result.value {
                if let code = err.code {
                    if true == error.successCodes.contains(code) {
                        inform.show()
                    }
                }
            }
        }
    }
}

public extension DataRequest {
    @discardableResult
    func load(load: MBLoadable = MBLoadType.none) -> Self {
        load.begin()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.5) {
            load.end()
        }
        return response { (response: DefaultDataResponse) in
//            load.end()
        }
    }
}


public extension DownloadRequest {
    @discardableResult
    func progress(progress: MBProgressable) -> Self {
        return downloadProgress(closure: { (prog: Progress) in
            progress.progress(prog)
        })
    }
    
    @discardableResult
    func load(load: MBLoadable = MBLoadType.none) -> Self {
        load.begin()
        return response { (response: DefaultDownloadResponse) in
            load.end()
        }
    }
}

public extension UploadRequest {
    @discardableResult
    func progress(progress: MBProgressable) -> Self {
        return uploadProgress { (prog: Progress) in
            progress.progress(prog)
        }
    }
}
