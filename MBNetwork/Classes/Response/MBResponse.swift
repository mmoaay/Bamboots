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
    ///   - error: Object conforms to `MBJSONErrorable` protocol, used for serializing JSON error data from service.
    ///   - warn: Object conforms to `MBWarnable` protocol, used for showing warning message when error occurs.
    ///   - completionHandler: The closure called once the error code exsists in error's `successCodes` set.
    /// - Returns: The request.
    @discardableResult
    func warn<T: MBJSONErrorable>(
        error: T,
        warn: MBWarnable = MBMessageType.none,
        completionHandler: ((MBJSONErrorable) -> Void)? = nil
        ) -> Self {

        return response(completionHandler: { (response: DefaultDataResponse) in
            if let err = response.error {
                warn.show(error: err.localizedDescription)
            }
        }).responseObject(queue: nil, keyPath: nil, mapToObject: nil, context: nil) { (response: DataResponse<T>) in
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
    ///   - error: Object conforms to `MBJSONErrorable` protocol, used for serializing JSON error data from service.
    ///   - inform: Object conforms to 1MBInformable1 protocol, used for showing inform message when request completed successfully.
    /// - Returns: The request.
    @discardableResult
    func inform<T: MBJSONErrorable>(error: T, inform: MBInformable = MBMessageType.none) -> Self {

        return responseObject(queue: nil, keyPath: nil, mapToObject: nil, context: nil) { (response: DataResponse<T>) in
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
    /// Show mask when request begins and hide mask when request ends
    ///
    /// - Parameter load: Object conforms to `MBLoadable` protocol
    /// - Returns: The request.
    @discardableResult
    func load(load: MBLoadable = MBLoadType.none) -> Self {
        load.begin()
        return response { (response: DefaultDataResponse) in
            load.end()
        }
    }
}

public extension DownloadRequest {
    /// Show progress of the request
    ///
    /// - Parameter progress: Object conforms to `MBProgressable` protocol
    /// - Returns: The request.
    @discardableResult
    func progress(progress: MBProgressable) -> Self {
        return downloadProgress(closure: { (prog: Progress) in
            progress.progress(prog)
        })
    }

    /// Show mask when request begins and hide mask when request ends
    ///
    /// - Parameter load: Object conforms to `MBLoadable` protocol
    /// - Returns: The request.
    @discardableResult
    func load(load: MBLoadable = MBLoadType.none) -> Self {
        load.begin()
        return response { (response: DefaultDownloadResponse) in
            load.end()
        }
    }
}

public extension UploadRequest {
    /// Show progress of the request
    ///
    /// - Parameter progress: Object conforms to `MBProgressable` protocol
    /// - Returns: The request.
    @discardableResult
    func progress(progress: MBProgressable) -> Self {
        return uploadProgress { (prog: Progress) in
            progress.progress(prog)
        }
    }
}
