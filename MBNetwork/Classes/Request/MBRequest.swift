//
//  MBRequester.swift
//  Pods
//
//  Created by Perry on 16/7/6.
//
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

public extension MBRequestable  {

    /// request
    ///
    /// - Parameters:
    ///   - form:
    ///   - load:
    ///   - serialize: 
    public func request(_ form: MBRequestFormable, load: MBLoadable = MBLoadType.none) -> DataRequest  {
        load.begin()
        return Alamofire.request(form.url, method: form.method, parameters: form.parameters(), encoding: form.encoding(), headers: form.headers()).response(completionHandler: { (response: DefaultDataResponse) in
            load.end()
        })
    }
    
    public func download(_ form: MBDownloadFormable, load: MBLoadable = MBLoadType.none) -> DownloadRequest {
        load.begin()
        return Alamofire.download(form.url, method: form.method, parameters: form.parameters(), encoding: form.encoding(), headers: form.headers(), to: form.destination).response { (response: DefaultDownloadResponse) in
            load.end()
            }
    }
    
    public func download(_ form: MBDownloadResumeFormable, load: MBLoadable = MBLoadType.none) -> DownloadRequest {
        load.begin()
        return Alamofire.download(resumingWith: form.resumeData, to: form.destination).response { (response: DefaultDownloadResponse) in
            load.end()
        }
    }
    
    public func upload(_ form: MBUploadDataFormable, load: MBLoadable = MBLoadType.none) -> UploadRequest {
        load.begin()
        return Alamofire.upload(form.data, to: form.url, method: form.method, headers: form.headers()).response(completionHandler: { (response: DefaultDataResponse) in
            load.end()
        })
    }
    
    public func upload(_ form: MBUploadFileFormable, load: MBLoadable = MBLoadType.none) -> UploadRequest {
        load.begin()
        return Alamofire.upload(form.fileURL, to: form.url, method: form.method, headers: form.headers()).response(completionHandler: { (response: DefaultDataResponse) in
            load.end()
        })
    }
    
    public func upload(_ form: MBUploadMultiFormDataFormable, load: MBLoadable = MBLoadType.none) {
        Alamofire.upload(multipartFormData: form.multipartFormData, usingThreshold: form.encodingMemoryThreshold, to: form.url, method: form.method, headers: form.headers(), encodingCompletion: form.encodingCompletion)
    }
    
    public func upload(_ form: MBUploadStreamFormable, load: MBLoadable = MBLoadType.none) -> UploadRequest {
        load.begin()
        return Alamofire.upload(form.stream, to: form.url, method: form.method, headers: form.headers()).response(completionHandler: { (response: DefaultDataResponse) in
            load.end()
        })
    }
}

// MARK: - MBRequestable

/**
 满足 MBRequestable 协议的类型可以进行网络请求
 */
public protocol MBRequestable: class{
    
}




