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
    @discardableResult
    func request(_ form: MBRequestFormable) -> DataRequest  {
        return Alamofire.request(form.url, method: form.method, parameters: form.parameters(), encoding: form.encoding(), headers: form.headers())
    }
    
    @discardableResult
    func download(_ form: MBDownloadFormable) -> DownloadRequest {
        return Alamofire.download(form.url, method: form.method, parameters: form.parameters(), encoding: form.encoding(), headers: form.headers(), to: form.destination)
    }
    
    @discardableResult
    func download(_ form: MBDownloadResumeFormable) -> DownloadRequest {
        return Alamofire.download(resumingWith: form.resumeData, to: form.destination)
    }
    
    @discardableResult
    func upload(_ form: MBUploadDataFormable) -> UploadRequest {
        return Alamofire.upload(form.data, to: form.url, method: form.method, headers: form.headers())
    }
    
    @discardableResult
    func upload(_ form: MBUploadFileFormable) -> UploadRequest {
        return Alamofire.upload(form.fileURL, to: form.url, method: form.method, headers: form.headers())
    }
    
    @discardableResult
    func upload(_ form: MBUploadMultiFormDataFormable, completion: ((UploadRequest) -> Void)?) {
        Alamofire.upload(multipartFormData: form.multipartFormData, usingThreshold: form.encodingMemoryThreshold, to: form.url, method: form.method, headers: form.headers(), encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                completion?(upload)
                break
            case .failure(let encodingError):
                print(encodingError)
                break
            }
        }
)
    }
    
    @discardableResult
    func upload(_ form: MBUploadStreamFormable) -> UploadRequest {
        return Alamofire.upload(form.stream, to: form.url, method: form.method, headers: form.headers())
    }
}

// MARK: - MBRequestable

/**
 满足 MBRequestable 协议的类型可以进行网络请求
 */
public protocol MBRequestable: class{
    
}




