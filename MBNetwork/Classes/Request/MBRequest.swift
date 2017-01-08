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

    
    /// Creates a `DataRequest` from the specified `form`
    ///
    /// - Parameter form: Object conforms to `MBRequestFormable` protocol.
    /// - Returns: The created `DataRequest`.
    @discardableResult
    func request(_ form: MBRequestFormable) -> DataRequest  {
        return Alamofire.request(form.url, method: form.method, parameters: form.parameters(), encoding: form.encoding(), headers: form.headers())
    }
    
    /// Creates a `DownloadRequest` from the specified `form`
    ///
    /// - Parameter form: Object conforms to `MBDownloadFormable` protocol.
    /// - Returns: The created `DownloadRequest`.
    @discardableResult
    func download(_ form: MBDownloadFormable) -> DownloadRequest {
        return Alamofire.download(form.url, method: form.method, parameters: form.parameters(), encoding: form.encoding(), headers: form.headers(), to: form.destination)
    }
    
    /// Creates a `DownloadRequest` from the specified `form`
    ///
    /// - Parameter form: Object conforms to `MBDownloadResumeFormable` protocol.
    /// - Returns: The created `DownloadRequest`.
    @discardableResult
    func download(_ form: MBDownloadResumeFormable) -> DownloadRequest {
        return Alamofire.download(resumingWith: form.resumeData, to: form.destination)
    }
    
    /// Creates an `UploadRequest` from the specified `form`
    ///
    /// - Parameter form: Object conforms to `MBUploadDataFormable` protocol.
    /// - Returns: The created `DownloadRequest`.
    @discardableResult
    func upload(_ form: MBUploadDataFormable) -> UploadRequest {
        return Alamofire.upload(form.data, to: form.url, method: form.method, headers: form.headers())
    }
    
    /// Creates an `UploadRequest` from the specified `form`
    ///
    /// - Parameter form: Object conforms to `MBUploadFileFormable` protocol.
    /// - Returns: The created `DownloadRequest`.
    @discardableResult
    func upload(_ form: MBUploadFileFormable) -> UploadRequest {
        return Alamofire.upload(form.fileURL, to: form.url, method: form.method, headers: form.headers())
    }
    
    
    /// Encodes `form` and calls `completion` with new `UploadRequest` using the `form`
    ///
    /// - Parameters:
    ///   - form: Object conforms to `MBUploadMultiFormDataFormable` protocol.
    ///   - completion: The closure called when the upload is complete
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
    
    /// Creates an `UploadRequest` from the specified `form`
    ///
    /// - Parameter form: Object conforms to `MBUploadStreamFormable` protocol.
    /// - Returns: The created `DownloadRequest`.
    @discardableResult
    func upload(_ form: MBUploadStreamFormable) -> UploadRequest {
        return Alamofire.upload(form.stream, to: form.url, method: form.method, headers: form.headers())
    }
}


///  Network request protocol, object conforms to this protocol can make network request
public protocol MBRequestable: class{
    
}




